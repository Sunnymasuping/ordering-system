<template>
	<view class="pro-item">
		<view class="pic">
			<image :src="dish.picture" mode="aspectFill" style="width: 100%; height: 100%; object-fit: contain;">
			</image>
		</view>
		<view class="text">
			<view class="title">{{ dish.dishName }}</view>
			<view class="price">
				<view class="big">￥{{ dish.price }}</view>
			</view>
			<view class="small">{{dish.specification}}</view>
		</view>
		<view class="numbox">
			<view>
				<pro-num-box :dish="dish"></pro-num-box>
			</view>
		</view>
	</view>
</template>

<script>
	import {
		mapGetters
	} from 'vuex';

	export default {
		name: "product-item",
		computed: {
			...mapGetters(["carsList"]),
		},
		props: {
			dish: {
				type: Object
			}
		},
		data() {
			return {

			};
		},
		methods: {

		}
	}
</script>

<style lang="scss" scoped>
	.pro-item {
		width: 100%;
		@include flex-box();
		padding: 25rpx 0;

		.pic {
			width: 180rpx;
			height: 180rpx;
			border-radius: 20rpx;
			overflow: hidden;

			.img {
				width: 100%;
				height: 100%;
			}
		}

		.text {
			flex: 1;
			padding-left: 20rpx;

			.title {
				font-size: 34rpx;
				font-weight: bold;
				@include ellipsis();
			}

			.price {
				@include flex-box-set(start, end);
				font-weight: bold;
				padding: 25rpx 0;

				.big {
					font-size: 34rpx;
					color: $brand-theme-color;
				}

				.small {
					font-size: 26rpx;
					opacity: 0.4;
					text-decoration: line-through;
					padding-left: 10rpx;
				}
			}

			.discount {
				font-size: 22rpx;
				color: $brand-theme-color;
				padding: 3rpx 8rpx;
				border: 1rpx solid $brand-theme-color;
				display: inline-block;
				border-radius: 6rpx;
			}

			.numbox {
				position: absolute;
				right: 0;
				bottom: 0;

				.skuSelect {
					height: 40rpx;
					padding: 0 10rpx;
					background: $brand-theme-color;
					font-size: 28rpx;
					color: #fff;
				}

			}
		}

	}
</style>