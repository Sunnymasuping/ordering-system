<template>
	<view class="orderDetail">
		<view class="payment">
			<icon type="success" color="#19be6b" size="50"></icon>
			<view class="text">
				<view class="big">
					实付款 ¥{{ order.sum }}
				</view>
				<view class="small">订单已完成</view>
			</view>
		</view>

		<view class="info">
			<view class="viewOut">
				<view class="title">订单信息</view>
				<view class="body">
					<view class="row">订单编号：{{ order.oid }}</view>
					<view class="row">下单时间：{{ order.createtime }}</view>
					<view class="row">完成时间：{{ order.overtime }}</view>
					<view class="row">支付方式：微信支付</view>
					<view class="row">用餐方式：{{ order.way }}</view>
					<view class="row">订单总价：{{ order.sum }}</view>
				</view>
			</view>
			<view class="viewOut">
				<view class="title">备注</view>
				<view class="body">
					<view class="row">{{ order.remark }}</view>
				</view>
			</view>
		</view>

		<view class="goodsList">
			<view class="title">菜品列表</view>
			<view class="body">
				<view v-for="(dish, index) in dishes" :key="index" class="row">{{ dish }}</view>
			</view>
		</view>
		<view class="write-review-btn">
			<u-button @click="showPopup = true">写留言</u-button>
		</view>

		<!-- 弹窗部分 -->
		<view class="popup" v-if="showPopup">
			<view class="popup-inner">
				<view class="popup-header">写留言</view>
				<view class="popup-body">
					<view class="form-group">
						<label>评分：</label>
						<u-rate :min-count="1" count="5" v-model="ratingValue" @change="updateRating"></u-rate>
					</view>
					<view class="form-group">
						<label>留言内容：</label>
						<textarea v-model="newReview.rcontent" rows="3" placeholder="请输入留言内容" style="margin-top: 22rpx;"></textarea>
					</view>
				</view>
				<view class="popup-footer">
					<u-button @click="showPopup = false">取消</u-button>
					<u-button @click="submitReview">提交</u-button>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				order: {}, // 初始化为空对象
				dishes: [], // 菜品列表
				showPopup: false, // 控制弹窗显示
				ratingValue: 0, // 新评分值
				newReview: { // 新留言数据
					rscore: '',
					rcontent: ''
				}
			};
		},
		methods: {
			// 评分
			updateRating(value) {
				const ratingMap = {
					1: '0',
					2: '25',
					3: '50',
					4: '75',
					5: '100'
				};
				this.newReview.rscore = ratingMap[value];
			},
			// 提交留言
			submitReview() {
				const cid = uni.getStorageSync('cid'); // 从缓存中获取顾客账号
				const now = new Date();
				const rtime =
					`${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-${String(now.getDate()).padStart(2, '0')}`;

				// 设置留言数据
				this.newReview.cid = cid;
				this.newReview.rtime = rtime;
				
				console.log(this.newReview)
				// 发送请求保存留言
				uni.request({
					url: 'http://localhost:8077/insertReview',
					method: 'POST',
					data: this.newReview,
					success: (res) => {
						if (res.statusCode === 200) {
							uni.showToast({
								title: '留言成功',
								icon: 'success'
							});
							this.fetchOrderDetail(); // 重新获取订单详情（此处需根据实际情况调整）
							this.newReview.rscore = '';
							this.newReview.rcontent = '';
							this.showPopup = false; // 关闭弹窗
						} else {
							console.error('Failed to submit review:', res);
							uni.showToast({
								title: '留言失败',
								icon: 'none'
							});
						}
					},
					fail: (err) => {
						console.error('Request error:', err);
						uni.showToast({
							title: '请求失败',
							icon: 'none'
						});
					}
				});
			},
			fetchOrderDetail(oid) {
				uni.request({
					url: `http://localhost:8077/selectOrderByOid?oid=${oid}`,
					method: 'GET',
					success: (res) => {
						if (res.statusCode === 200) {
							this.order = res.data;
							this.dishes = res.data.ocontent.split('/');
						} else {
							console.error('Failed to fetch order details:', res);
						}
					},
					fail: (err) => {
						console.error('Request error:', err);
					}
				});
			},
		},
		onLoad(options) {
			if (options.oid) {
				this.fetchOrderDetail(options.oid);
			} else {
				console.error('No OID received in options');
			}
		}
	};
</script>

<style>
	.orderDetail {
		padding: 15px;
	}

	.payment {
		display: flex;
		align-items: center;
		margin-bottom: 20px;
	}

	.payment icon {
		margin-right: 10px;
	}

	.text {
		flex: 1;
	}

	.big {
		font-size: 20px;
		font-weight: bold;
		margin-bottom: 5px;
	}

	.small {
		font-size: 14px;
		color: #888;
	}

	.complete {
		font-size: 14px;
		color: #19be6b;
	}

	.info {
		margin-bottom: 20px;
	}

	.viewOut {
		background-color: #fff;
		border-radius: 10px;
		padding: 15px;
		margin-bottom: 15px;
		box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	}

	.title {
		font-size: 16px;
		font-weight: bold;
		margin-bottom: 10px;
	}

	.body {
		font-size: 14px;
	}

	.row {
		margin-bottom: 10px;
	}

	.goodsList {
		background-color: #fff;
		border-radius: 10px;
		padding: 15px;
		box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
		margin-bottom: 10px;
	}

	.goodsList .title {
		font-size: 16px;
		font-weight: bold;
		margin-bottom: 10px;
	}

	.goodsList .body .row {
		font-size: 14px;
		margin-bottom: 10px;
	}

	.popup {
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-color: rgba(0, 0, 0, 0.5);
		display: flex;
		justify-content: center;
		align-items: center;
		z-index: 999;
	}

	.popup-inner {
		width: 80%;
		max-width: 400px;
		background-color: #fff;
		border-radius: 8px;
		padding: 16px;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
	}

	.popup-header {
		font-size: 18px;
		font-weight: bold;
		margin-bottom: 12px;
	}

	.popup-body {
		margin-bottom: 12px;
	}

	.form-group {
		margin-bottom: 12px;
	}

	.form-group label {
		font-weight: bold;
	}

	.popup-footer {
		display: flex;
		justify-content: flex-end;
	}

	.popup-footer u-button {
		margin-left: 12px;
	}
</style>