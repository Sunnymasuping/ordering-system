<template>
	<view class="carProItem" v-if="dish">
		<view class="left">
			<view class="pic">
				<image class="img" :src="dish.picture" mode="aspectFill"></image>
			</view>
			<view class="text">
				<view class="title">{{ dish.dishName }}</view>
				<view class="sku">{{dish.specification}}</view>
				<view class="price">
					<view class="big" v-if="dish">￥{{ dish.price }}</view>

				</view>
			</view>
		</view>
		<view class="right">
			<pro-num-box v-if="dish" :dish="dish"></pro-num-box>
		</view>
	</view>

</template>

<script>
	import {
		mapGetters
	} from "vuex"
	export default {
		name: "car-pro-item",
		data() {
			return {

			};
		},
		props: {
			dish: {
				type: Object,
				defaultValue() {
					return {}
				}
			}
		}
	}
</script>

<style lang="scss" scoped>
	.carProItem {
		padding: 20rpx 0;
		border-bottom: 1px solid $border-color-light;
		position: relative;

		.left {
			width: 500rpx;
			@include flex-box();

			.pic {
				width: 110rpx;
				height: 110rpx;

				.img {
					width: 100%;
					height: 100%;
				}
			}

			.text {
				flex: 1;
				padding-left: 20rpx;

				.title {
					font-size: 28rpx;
					@include ellipsis(2);
				}

				.sku {
					font-size: 22rpx;
					color: #999;
					padding: 5rpx 0;
				}

				.price {
					@include flex-box-set(start);

					.big {
						font-weight: bold;
						font-size: 28rpx;
						color: $brand-theme-color;
					}

					.small {
						font-size: 26rpx;
						color: $text-font-color-3;
					}

				}

			}

		}

		.right {
			position: absolute;
			right: 0;
			bottom: 20rpx;
		}

	}
</style>