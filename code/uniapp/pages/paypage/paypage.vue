<template>
	<view class="paypage">

		<view class="container">
			<view class="card">
				<view class="goodsList">
					<goods-list></goods-list>
				</view>
			</view>

			<view class="card">
				<view class="paytype">
					<!-- 支付宝和微信支付选项 -->
					<view class="box" :class="payMethod === 'alipay' ? 'active' : ''"
						@click="selectPayMethod('alipay')">
						<u-icon name="zhifubao" color="#1578FF" class="icon" size="26"></u-icon>
						<text class="font">支付宝</text>
					</view>
					<view class="box" :class="payMethod === 'wxpay' ? 'active' : ''" @click="selectPayMethod('wxpay')">
						<u-icon name="weixin-fill" color="#04C15F" class="icon" size="26"></u-icon>
						<text class="font">微信</text>
					</view>
				</view>

				<view class="paytype">
					<!-- 堂食和打包选项 -->
					<view class="box" :class="diningMethod === '堂食' ? 'active' : ''" @click="selectDiningMethod('堂食')">
						<u-icon name="堂食" color="#FF8C00" class="icon" size="26"></u-icon>
						<text class="font">堂食</text>
					</view>
					<view class="box" :class="diningMethod === '打包' ? 'active' : ''" @click="selectDiningMethod('打包')">
						<u-icon name="打包" color="#FF6347" class="icon" size="26"></u-icon>
						<text class="font">打包</text>
					</view>
				</view>
			</view>
			<!-- 备注栏 -->
			<view class="card remark">
				<textarea v-model="remark" placeholder="请输入备注信息"></textarea>
			</view>

			<view class="payTabbar">
				<car-layout type="pay" :remark="remark" :diningMethod="diningMethod"></car-layout>

			</view>
		</view>
	</view>
</template>

<script>
	import {
		mapGetters
	} from 'vuex';

	export default {
		computed: {
			...mapGetters(['carsList', 'totalPrice', 'buyNum']),
		},
		data() {
			return {
				payMethod: "alipay",
				diningMethod: "堂食",
				remark: "", // 添加备注栏的绑定值
			};
		},
		methods: {
			// 选择支付类型
			selectPayMethod(value) {
				this.payMethod = value;
			},
			// 选择用餐类型
			selectDiningMethod(value) {
				this.diningMethod = value;
			}
		}
	};
</script>

<style lang="scss">
	.page {
		background: page-bg-color;
	}

	.paypage {
		padding: 30rpx;

		.goodsList {
			margin-top: 30rpx;
		}

		.paytype {
			display: flex;
			justify-content: space-between;
			margin-bottom: 20rpx;

			.box {
				width: 49%;
				height: 75rpx;
				background: #fff;
				border-radius: 10rpx;
				display: flex;
				align-items: center;
				justify-content: center;
				border: 1px solid #fff;

				.font {
					padding-left: 10rpx;
				}
			}

			.box.active {
				border-color: #1578FF;
				color: #1578FF;
			}

			.box[value='wxpay'].active {
				border-color: #04C15F;
				color: #04C15F;
			}

			.box[value='堂食'].active {
				border-color: #FF8C00;
				color: #FF8C00;
			}

			.box[value='打包'].active {
				border-color: #FF6347;
				color: #FF6347;
			}
		}

		.remark {
			margin-top: 0rpx;
		}

		.payTabbar {
			position: fixed;
			width: 100%;
			bottom: 0;
			left: 0;
		}

		.container {
			display: flex;
			flex-direction: column;
			gap: 7px;
		}

		.card {
			background-color: #fff;
			padding: 10px;
			margin: 0px;
			border-radius: 8px;
			box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
		}

		.paytype .box {
			display: flex;
			align-items: center;
			padding: 10px;
			cursor: pointer;
			border: 1px solid #e0e0e0;
			border-radius: 4px;
			margin-bottom: 10px;
		}

		.paytype .box.active {
			border-color: #409eff;
		}

		.icon {
			margin-right: 10px;
		}

		.remark textarea {
			width: 92%;
			height: 50px;
			padding: 0px;
			border: 1px solid #e0e0e0;
			border-radius: 4px;
		}
	}
</style>