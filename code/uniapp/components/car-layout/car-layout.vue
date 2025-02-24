<template>
	<view>
		<view class="carLayout">
			<view class="goods" v-if="carShow">
				<view class="head">
					<view class="text">已选商品</view>
					<view class="empty" @click="clearCart">清空</view>
				</view>

				<scroll-view scroll-y="true" class="body">
					<view class="sContent">
						<view class="caritem" v-for="dish in carsList" :key="dish.goodsid">
							<car-pro-item :dish="dish"></car-pro-item>
						</view>
					</view>
				</scroll-view>
			</view>

			<view class="content">
				<view class="left">
					<view v-if="!type" class="icon" hover-class="iconhover" hover-stay-time="50" @tap="clickCarIcon">
						<u-icon name="shopping-cart" size="34" color="#EC544F"></u-icon>
						<view class="num">{{ buyNum }}</view>
					</view>
					<view class="price">合计<text class="text">￥{{ totalPrice }}</text></view>
				</view>
				<view class="right">
					<view class="btn disable" v-if="!type" @click="goPay">选好了</view>
					<view class="btn" v-else @click="confirmPay">支付</view>
				</view>
			</view>

			<view class="safe-area-bottom"></view>
		</view>
		<u-overlay :show="carShow" z-index="9" @click="carShow = false"></u-overlay>
	</view>
</template>

<script>
	import {
		mapGetters,
		mapMutations
	} from 'vuex';

	export default {
		name: "car-layout",
		data() {
			return {
				carShow: false
			};
		},
		props: {
			type: String,
			default: '',
			remark: String,
			diningMethod: String
		},
		computed: {
			...mapGetters(["carsList", "totalPrice", "buyNum"])
		},
		methods: {
			...mapMutations(['clearCarsList', 'setcarsList']),
			clearCart() {
				this.clearCarsList();
			},
			getCurrentTime() {
				const currentTime = new Date();

				const year = currentTime.getFullYear();
				const month = String(currentTime.getMonth() + 1).padStart(2, '0'); // 补全两位
				const day = String(currentTime.getDate()).padStart(2, '0'); // 补全两位
				const hours = String(currentTime.getHours()).padStart(2, '0'); // 补全两位
				const minutes = String(currentTime.getMinutes()).padStart(2, '0'); // 补全两位
				const seconds = String(currentTime.getSeconds()).padStart(2, '0'); // 补全两位

				const formattedTime = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;

				console.log(formattedTime);
				return formattedTime;
			},
			getOContent() {
				const orderContent = this.carsList.map(dish => `${dish.dishName}`).join('/');
				return orderContent;
			},
			confirmPay() {
				const cid = uni.getStorageSync('cid'); // 从缓存中获取cid
				console.log(this.getCurrentTime());
				console.log(cid);
				const order = {
					ocontent: this.getOContent(),
					createtime: this.getCurrentTime(),
					overtime: "",
					ostatus: "已支付",
					remark: this.remark,
					sum: this.totalPrice,
					cid: cid,
					way: this.diningMethod
				};
				const url = '/insertOrder';
				console.log(order);
				this.$request.post(url, order)
					.then(response => {
						console.log('订单提交成功:', response);
						this.clearCarsList(); // 成功提交订单后清空购物车
						uni.showToast({
							title: '成功付款，请等待出餐',
							icon: 'success',
							duration: 2000, // 提示显示时间
							complete: () => {
								setTimeout(() => {
									uni.switchTab({
										url: '/pages/index/index'
									});
								}, 2000); // 等待提示信息显示完毕后再跳转
							}
						});
					})
					.catch(error => {
						console.log('订单提交失败:', error);
					});
			},
			goPay() {
				if (this.buyNum > 0) {
					uni.navigateTo({
						url: "/pages/paypage/paypage"
					});
				} else {
					uni.showToast({
						title: '请先选择菜品',
						icon: 'none'
					});
				}
			},
			clickCarIcon() {
				this.carShow = !this.carShow;
			}
		}
	};
</script>

<style lang="scss" scoped>
	.carLayout {
		position: relative;
		z-index: 10;

		.goods {
			border-bottom: 1px solid $border-color-light;
			padding: 30rpx 30rpx 0;
			border-radius: 20rpx 20rpx 0 0;
			background: #fff;

			.head {
				@include flex-box();
				color: $text-font-color-3;
				padding: 25rpx 0;

				.empty {
					color: $brand-theme-color-aux;
					cursor: pointer;
				}
			}

			.body {
				height: 550rpx;
			}
		}

		.content {
			@include flex-box();
			padding: 0 30rpx;
			height: 140rpx;
			background: #fff;

			.left {
				@include flex-box();

				.icon {
					width: 80rpx;
					height: 80rpx;
					background: #EEEFEE;
					border-radius: 10rpx;
					@include flex-box-set();
					position: relative;
					margin-right: 30rpx;

					.num {
						width: 36rpx;
						height: 36rpx;
						background: $brand-theme-color;
						border-radius: 50%;
						color: #fff;
						position: absolute;
						right: -18rpx;
						top: -18rpx;
						font-size: 22rpx;
						@include flex-box-set();
					}
				}

				.iconhover {
					transform: scale(0.9);
				}

				.price {
					font-size: 28rpx;

					.text {
						font-size: 32rpx;
						font-weight: bold;
					}
				}
			}

			.right {
				.btn {
					width: 210rpx;
					height: 75rpx;
					background: $brand-theme-color;
					@include flex-box-set();
					color: #fff;
					border-radius: 10rpx;

					&.disable {
						opacity: 0.6;
					}
				}
			}

			.safe-area-bottom {
				width: 100%;
				height: env(safe-area-inset-bottom);
				background: #fff;
			}
		}
	}
</style>