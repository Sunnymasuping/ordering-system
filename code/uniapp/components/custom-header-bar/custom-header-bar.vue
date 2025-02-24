<template>
	<view class = "customHead">
		<view class = "bg">
			<image class ="bgimg" src="../../static/images/image2.jpg" mode="aspectFill"></image>
		</view>
		自定义头部
	</view>
</template>

<script>
	export default {
		name:"custom-header-bar",
		data() {
			return {
				
			};
		}
	}
</script>

<style lang="scss" scoped>
.customHead{
	height:200rpx;
	overflow: hidden;
	.bg{
		width: 100%;
		height: 100%;
		background: #000;
		.bgimg{
			width: 100%;
			height: 100%;
			filter: blur(3rpx);
			transform: scale(1.5);
		}
	}
}
</style>