<template>
	<view class="pronumbox">
		<u-number-box v-model="dish.numvalue" min="0" max="99" @change="numChange">
			<view slot="minus" class="minus numbtn" :class="{'none': dish.numvalue <= 0}">
				<u-icon name="minus" color="#000000" size="12"></u-icon>
			</view>
			<text slot="input" class="input" :class="{'none': dish.numvalue < 0}">{{ dish.numvalue }}</text>
			<view slot="plus" class="plus numbtn">
				<u-icon name="plus" color="#000000" size="12"></u-icon>
			</view>
		</u-number-box>
	</view>
</template>

<script>
	import {
		mapMutations
	} from "vuex";

	export default {
		name: "pro-num-box",
		props: {
			dish: {
				type: Object,
				required: true
			}
		},
		data: {
			dish: {
				numvalue: 0,
			}
		},
		methods: {
			...mapMutations(["setcarsList"]),
			numChange(e) {
				console.log(e.value);
				console.log(this.dish);
				this.setcarsList({
					dish: this.dish,
					num: e.value
				});
			}
		}
	};
</script>

<style lang="scss" scoped>
	.pronumbox {
		.numbtn {
			width: 40rpx;
			height: 40rpx;
			display: flex;
			align-items: center;
			justify-content: center;
		}

		.minus {
			border: 1px solid #ccc;
		}

		.plus {
			background: $brand-theme-color;
		}

		.input {
			width: 60rpx;
			height: 40rpx;
			font-size: 26rpx;
			color: #888;
			display: flex;
			align-items: center;
			justify-content: center;
		}

		.none {
			display: none;
		}
	}
</style>