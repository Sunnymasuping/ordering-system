<template>
	<view class="message-board">
		<view v-for="(review, index) in reviews" :key="review.rid" class="review-card" @click="navigateToReply(index)">
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
</template>

<script>
	export default {
		data() {
			return {
				reviews: [] // 初始化为空数组
			};
		},
		methods: {
			fetchReviews() {
				const cid = uni.getStorageSync('cid'); // 从缓存中获取cid
				console.log(cid)
				uni.request({
					url: `http://localhost:8077/selectMyReview?cid=${cid}`,
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
			navigateToReply(index) {
				const review = this.reviews[index];
				uni.navigateTo({
					url: `/pages/review/reply?rid=${review.rid}&rscore=${review.rscore}&rcontent=${review.rcontent}&rtime=${review.rtime}&cid=${review.cid}`
				});
			}
		},
		onLoad() {
			this.fetchReviews();
		}
	};
</script>

<style lang="scss">
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

	.review-card:hover {
		transform: scale(1.05);
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