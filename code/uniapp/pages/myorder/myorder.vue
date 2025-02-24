<template>
	<view class="myorder">
		<!-- 顶部导航栏 -->
		<view class="navbar">
			<text :class="{ active: ostatus === '已支付' }" @click="filterStatus('已支付')">已支付</text>
			<text :class="{ active: ostatus === '已取消' }" @click="filterStatus('已取消')">已取消</text>
			<text :class="{ active: ostatus === '已完成' }" @click="filterStatus('已完成')">已完成</text>
		</view>

		<!-- 订单列表 -->
		<view class="row" v-for="item in filteredOrders" :key="item.oid" @click="goDetail(item)">
			<view class="head">
				<view class="oid">{{ item.oid }}<text class="way">{{ item.way }}</text></view>
				<view class="state">
					<text>{{ item.ostatus }}</text>
				</view>
			</view>
			<view class="body">{{ item.ocontent }}</view>
			<view class="footer">
				<view class="createtime">{{ item.createtime }}</view>
				<view class="sum">
					共{{ getDishCount(item.ocontent) }}件商品，实付款<text class="price">¥{{ item.sum }}</text>
				</view>
			</view>
		</view>
	</view>
</template>



<script>
	export default {
		data() {
			return {
				ostatus: '已支付', // 当前筛选状态
				orders: [] // 初始化为空数组
			};
		},
		computed: {
			filteredOrders() {
				return this.orders.filter(order => order.ostatus === this.ostatus);
			}
		},
		methods: {
			filterStatus(status) {
				this.ostatus = status;
			},
			goDetail(item) {
				let url = "";
				if (item.ostatus === '已支付') {
					url = "/pages/myorder/detail1";
				} else if (item.ostatus === '已取消') {
					url = "/pages/myorder/detail2";
				} else if (item.ostatus === '已完成') {
					url = "/pages/myorder/detail3";
				}
				uni.navigateTo({
					url: `${url}?oid=${item.oid}`
				});
			},
			getDishCount(ocontent) {
				return ocontent.split('/').length;
			},
			fetchOrders() {
				const cid = uni.getStorageSync('cid'); // 从缓存中获取cid
				uni.request({
					url: `http://localhost:8077/selectMyOrder?cid=${cid}`,
					method: 'GET',
					success: (res) => {
						if (res.statusCode === 200) {
							this.orders = res.data;
						} else {
							console.error('Failed to fetch orders:', res);
						}
					},
					fail: (err) => {
						console.error('Request error:', err);
					}
				});
			}
		},
		mounted() {
			this.fetchOrders();
		}
	};
</script>



<style>
	.myorder {
		padding: 15px;
	}

	.navbar {
		display: flex;
		justify-content: space-around;
		background-color: #f5f5f5;
		padding: 10px 0;
		margin-bottom: 15px;
		border-radius: 10px;
	}

	.navbar text {
		font-size: 16px;
		color: #888;
		cursor: pointer;
	}

	.navbar text.active {
		color: #ff7f50;
		font-weight: bold;
	}

	.row {
		background-color: #fff;
		border-radius: 10px;
		box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
		margin-bottom: 8px;
		padding: 15px;
		cursor: pointer;
	}

	.head {
		display: flex;
		justify-content: space-between;
		margin-bottom: 10px;
	}

	.oid {
		font-size: 14px;
		font-weight: bold;
	}

	.way {
		font-size: 12px;
		color: #888;
		margin-left: 10px;
	}

	.state text {
		font-size: 14px;
		color: #19be6b;
	}

	.body {
		font-size: 14px;
		margin-bottom: 10px;
	}

	.footer {
		display: flex;
		justify-content: space-between;
	}

	.createtime {
		font-size: 25rpx;
		color: #888;
	}

	.sum {
		font-size: 25rpx;
	}

	.price {
		font-size: 25rpx;
		color: #e45656;
		font-weight: bold;
		margin-left: 5px;
	}
</style>