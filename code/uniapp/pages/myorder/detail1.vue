<template>
	<view class="orderDetail">
		<view class="payment">
			<icon type="success" color="#19be6b" size="50"></icon>
			<view class="text">
				<view class="big">
					实付款 ¥{{ order.sum }}
				</view>
				<view class="small">制作中，请稍等</view>
			</view>
		</view>

		<view class="info">
			<view class="viewOut">
				<view class="title">订单信息</view>
				<view class="body">
					<view class="row">订单编号：{{ order.oid }}</view>
					<view class="row">下单时间：{{ order.createtime }}</view>
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

		<u-button type="warning" @click="confirmCancelOrder">取消订单</u-button>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				order: {}, // 初始化为空对象
				dishes: [] // 菜品列表
			};
		},
		methods: {
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
			confirmCancelOrder() {
				uni.showModal({
					title: '确认取消',
					content: '您确定要取消订单吗？',
					success: (res) => {
						if (res.confirm) {
							this.cancelOrder();
						}
					}
				});
			},
			cancelOrder() {
				const updatedOrder = {
					oid: this.order.oid,
					ostatus: '已取消'
				};

				uni.request({
					url: 'http://localhost:8077/cancelOrder',
					method: 'POST',
					data: updatedOrder,
					success: (res) => {
						if (res.statusCode === 200 && res.data === '成功') {
							uni.showToast({
								title: '订单已取消',
								icon: 'success'
							});
							this.order.ostatus = '已取消'; // 更新本地状态
						} else {
							console.error('Failed to cancel order:', res);
							uni.showToast({
								title: '取消失败',
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
			}
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
		margin-bottom: 25rpx;
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

	.u-button {
		flex-shrink: 0;
	}
</style>