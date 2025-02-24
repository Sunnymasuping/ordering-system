<template>
	<view class="searchLayout">
		<u-search 
		placeholder="请输入搜索内容"
		v-model="keyword"
		clearabled
		showAction
		actionText="搜索"
		animation
		@search="onSearch"
		@custom="onSearch"
		>
		</u-search>
		
		<view class="historyList">
		<view class="item" v-for="item in historyList" :key="item">
		<view class="text">{{item}}</view><view class="close">
		<u-icon name="close" size="16" color="#999"></u-icon></view>
		</view></view>

		<!-- 搜索结果展示 -->
		<view class="searchResult" v-if="searchedDishes.length > 0">
		  <view class="item" v-for="dish in searchedDishes" :key="dish.dishId">
			<product-item :dish="dish"></product-item>
		  </view>
		  <view v-if="searchedDishes.length === 0" class="noResult">暂无搜索结果</view>
		</view>

	<car-layout v-if="buyNum>0" class="car-layout"></car-layout>
	</view>
</template>

<script>
	import {mapState,
			mapMutations,
			mapGetters
	} from "vuex"
	
	export default {
		data() {
			return {
				keyword:"",
				historyList:[],
				searchedDishes:[]  
			}
		},
		computed:{
			...mapState(["vuexValue1","vuexname"]),
			...mapGetters(["buyNum"])
		},
		methods: {
			onSearch(){
				this.historyList.unshift(this.keyword)
				//把搜索的关键字去重
				this.historyList = [...new Set(this.historyList)];

				
				// 模糊查询
				const url = '/dish/findDishByKeyWord?keyWord=' + encodeURIComponent(this.keyword);
				this.$request.get(url).then(res => {
					console.log(this.keyword, res);
					this.searchedDishes = res
					console.log("实际上的dish:",this.searchedDishes);
					 this.$forceUpdate(); // 在数据更新后调用 $forceUpdate() 强制更新视图
				}).catch(err => {
				console.error('搜索出错：', err);
				});
			}

		}
	}
</script>

<style lang="scss">




.searchLayout {
  position :relative;
  padding: 30rpx;
  min-height: 100vh;
  .historyList{
	  margin-top: 30rpx;
	  .item{
		@include flex-box();
		font-size: 32rpx;
		padding:30rpx 0;
		color:#333;
		border-bottom: 1px solid $border-color-light;
	  }
	  .content {
	    flex: 1; 
	  
	  }
	  .car-layout {
	
	    position :absolute;
	    bottom: 0;
	    left: 0;
	    width: 100%;
	    /* 其他样式设置，比如背景色、边框等 */
	  }
  }

}
</style>
