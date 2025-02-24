<template>
	<div class="container">
		<!-- 轮播图 -->
		<u-swiper :list="list3" indicator indicatorMode="line" circular height="500rpx"></u-swiper>

		<!-- 公告 -->
		<u-notice-bar text="欢迎光临！本店提供最新鲜的美食和最优质的服务。" mode="closeable"></u-notice-bar>

		<!-- 今日推荐菜品 -->
		<div class="recommendation">
			<u-cell-group title="今日推荐">
				<u-cell v-for="(item, index) in todayRecommend" :key="index" :title="item.name"
					:label="item.description">
					<template v-slot:right>
						<u-image :src="item.image" width="50" height="50"></u-image>
					</template>
				</u-cell>
			</u-cell-group>
		</div>

		<!-- 门店地址 -->
		<div class="store-address">
			<u-cell title="门店地址" :label="storeAddress"></u-cell>
		</div>
		
		<div class="store-address">
			<u-cell title="顾客留言" :label="review"></u-cell>
		</div>

		<view class="message-board">
			<view v-for="(review, index) in reviews" :key="review.rid" class="review-card">
				<view class="review-header">
					<u-rate :value="getStarCount(review.rscore)" disabled></u-rate>
					<text class="review-time">{{ review.rtime }}</text>
				</view>
				<view class="review-body">
					<text class="review-content">{{ review.rcontent }}</text>
				</view>
				<view class="review-footer">
					<text class="review-user">用户: {{ review.cid }}</text>
				</view>
			</view>
		</view>
	</div>
</template>

<script>
	export default {
		data() {
			return {
				reviews: [], // 初始化为空数组
				list3: [], // 轮播图列表
				userAvatar: '/static/logo.png', // 用户头像的默认地址
				userCid: '', // 用户CID
				todayRecommend: [{
						name: '推荐菜品:爆炒鳝肉',
						description: '本店新品店长大力推荐，欢迎顾客品尝！！',
					},
				],
				storeAddress: '重庆市巴南区花溪街道红光大道69号'
			};
		},
		created() {
			this.fetchPictures(); // 获取轮播图数据
		},
		methods: {
			fetchPictures() {
				uni.request({
					url: 'http://localhost:8077/pictures/all',
					method: 'GET',
					success: (res) => {
						if (res.statusCode === 200 && res.data.length === 4) { // 确保获取到4张图片
							// 按照 number 排序
							res.data.sort((a, b) => a.number - b.number);
							// 提取 url 列表并拼接完整路径
							this.list3 = res.data.map(picture => `http://localhost:8077${picture.url}`);
						} else {
							uni.showToast({
								title: '获取数据失败',
								icon: 'error'
							});
						}
					},
					fail: (err) => {
						console.error('获取图片数据失败', err);
						uni.showToast({
							title: '请求失败',
							icon: 'error'
						});
					}
				});
			},
			fetchReviews() {
				uni.request({
					url: 'http://localhost:8077/selectAllReview',
					method: 'GET',
					success: (res) => {
						if (res.statusCode === 200) {
							this.reviews = res.data;
						} else {
							console.error('Failed to fetch reviews:', res);
						}
					},
					fail: (err) => {
						console.error('Request error:', err);
					}
				});
			},
			getStarCount(score) {
				// 评分从0到100，转换为1到5颗星
				return Math.ceil(score / 20);
			},
		},
		onLoad() {
			this.fetchReviews();
		}
	};
</script>

<style lang="scss">
	.container {
		padding: 0rpx;
	}

	.recommendation {
		margin-top: 20rpx;
	}

	.store-address {
		margin-top: 20rpx;
	}

	.message-board {
		padding: 20px;
	}

	.review-card {
		background-color: #fff;
		padding: 15px;
		margin-bottom: 10px;
		border-radius: 10px;
		box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
		cursor: pointer;
		transition: transform 0.3s;
	}

	.review-header,
	.review-footer {
		display: flex;
		justify-content: space-between;
		margin-bottom: 10px;
	}

	.review-body {
		margin-bottom: 10px;
	}

	.review-score {
		font-weight: bold;
	}

	.review-time,
	.review-user {
		color: #999;
	}
</style>