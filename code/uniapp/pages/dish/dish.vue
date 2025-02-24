<template>
	<view class="home ">
		<custom-header-bar></custom-header-bar>
		<view class="wrapper">
			<view class="infoModel">
				<u-notice-bar text="本店提供免费打包,免费饮料,免费加米饭!!" mode="closeable"></u-notice-bar>
			</view>


			<view class="scrollLayout">
				<view class="leftScroll">
					<scroll-view class="sContent" scroll-y :scroll-top="leftScrollValue">
						<view class="navitem" :class="index==navIdx?'active':''" v-for="(category,index) in categories"
							:key="index" @click="clickNav(index)">
							{{category}}
						</view>
					</scroll-view>
				</view>

				<view class="rightScroll">

					<navigator url="/pages/search/search" class="searchView">
						<u-icon name="search" size="22" color="#576b95"></u-icon>搜索
					</navigator>


					<scroll-view @scroll="rightScrollEnt" :scroll-top="rightScrollValue" class="sContent" scroll-y
						scroll-with-animation>
						<view class="productView" v-if="dishes.length > 0">
							<u-sticky :customNavHeight="0" zIndex="2">
								<view class="proTitle">{{ categories[navIdx] }}</view>
							</u-sticky>
							<view class="proContent">
								<view class="proitem" v-for="pro in dishes" :key="pro.dishId">
									<product-item :dish="pro"></product-item>
								</view>
							</view>
						</view>
					</scroll-view>
				</view>
			</view>
		</view>

		<car-layout v-if="buyNum>=0"></car-layout>
	</view>
</template>

<script>
	import {
		mapState,
		mapMutations,
		mapGetters
	} from "vuex"


	export default {
		data() {
			return {
				navIdx: 0,
				leftScrollValue: 0,
				rightScrollValue: 0,
				rightHitArr: [],
				leftHitArr: [],
				categories: [],
				typeNum: 0,
				dishes: [], // 新增的属性
				clickType: ''
			}
		},
		onLoad() {
			this.fetchCategoryData();
			this.$nextTick(() => {
				this.getHeightArr();
			})
		},
		computed: {
			...mapState(["vuexValue1", "vuexname"]),
			...mapGetters(["buyNum", "carsList"])
		},
		methods: {
			clickNav(index) {
				if (index == this.navIdx) return;
				this.navIdx = index;
				this.fetchDishesByType(this.categories[index]); // 添加这行
				if (this.timeout) {
					clearTimeout(this.timeout);
				}
				this.timeout = setTimeout(() => {
					this.leftScrol1Value = this.leftHitArr[index];
					this.rightScrollValue = this.rightHitArr[index];
				}, 100);
			},
			fetchDishesByType(type) {
				this.clickType = type;
				const url = '/dish/findDishByType?type=' + encodeURIComponent(this.clickType);
				this.$request.get(url).then(res => {
					console.log(this.clickType, res);

					// 检查 res.dishes 是否存在并且是数组
					if (res.dishes && Array.isArray(res.dishes)) {
						this.dishes = res.dishes.map(dish => ({
							...dish,
							picture: `http://localhost:8077${dish.picture}` // 拼接图片地址
						})); // 使用深拷贝保存干净的数据到 this.dishes
						console.log("实际上的dish:", this.dishes);
					} else {
						console.warn("响应数据中没有 dishes 或 dishes 不是数组");
						this.dishes = []; // 如果没有 dishes 或 dishes 不是数组，则初始化为空数组
					}

					this.$forceUpdate(); // 在数据更新后调用 $forceUpdate() 强制更新视图
				}).catch(error => {
					console.error("请求失败：", error);
					this.dishes = []; // 请求失败时初始化 dishes 为空数组
				});
			},
			fetchFirstCategoryDishes() {
				if (this.categories.length > 0) {
					console.log("刷新第一个菜品方法有调用过");
					this.fetchDishesByType(this.categories[0]); // 默认获取第一个菜品类型的数据

				}
			},
			//获取滚动条内容高度
			getHeightArr() {
				let selectorQuery = uni.createSelectorQuery();
				//左侧滚到区域的节点组
				selectorQuery.selectAll(".navitem").boundingClientRect(rects => {
					this.leftHitArr = rects.map(item => item.top - 150)
				}).exec();
				//右侧滚到区域的节点组
				selectorQuery.selectAll(".productView").boundingClientRect(rects => {
					this.rightHitArr = rects.map(item => item.top - 150)
				}).exec();
				console.log(this.leftHitArr);
				console.log(this.rightHitArr);
			},
			//监听右侧滚动条的改变
			rightScrollEnt(e) {
				let scrollTop = e.detail.scrollTop;
				let idx = this.rightHitArr.findIndex((value, index, arr) => scrollTop >= value && scrollTop < arr[index +
					1])
				this.navIdx = idx;
				this.leftScrollValue = this.leftHitArr[idx];

			},
			fetchCategoryData() {
				this.$request.get('/dish/findAllType').then(res => {
					console.log(res);
					this.categories = res.categories;
					this.typeNum = res.typeNum;
					console.log('测试赋值Categories:', this.categories); // 打印categories到控制台
					console.log('测试赋值typeNum :', this.typeNum);
					if (this.categories.length > 0) {
						console.log("刷新第一个菜品方法有调用过");
						this.fetchDishesByType(this.categories[0]); // 默认获取第一个菜品类型的数据

					}
				});
			}

		}
	}
</script>

<style lang="scss" scoped>
	.home {
		height: 100vh;
		display: flex;
		flex-direction: column;

		.wrapper {
			flex: 1;
			background: #fff;
			border-radius: 20rpx 20rpx 0 0;
			margin-top: -20rpx;
			position: relative;
			z-index: 2;
			overflow: hidden;

			.infoModel {
				color: $text-font-color-1;
				display: flex;
				justify-content: space-between;
				align-items: center;
				height: 100rpx;
				background: #fff;
				padding: 0 30rpx;
				border-bottom: 1px soild $border-color;

				.right {
					@include flex-box();
					color: $brand-theme-color-aux;
					border-right: 1px soild $border-color;
				}
			}

			.scrollLayout {
				height: calc(100% - 100rpx);
				@include flex-box();

				.sContent {
					height: 100%;
				}

				.leftScroll {
					height: 100%;
					width: 190rpx;
					background: #ff7f50;

					.navitem {
						font-size: 30rpx;
						padding-left: 30rpx;
						line-height: 100rpx;
						color: $text-font-color-2;
						position: relative;

						&.active {
							color: $text-font-color-1;
							background: #fff;
						}
					}

				}

				.rightScroll {
					height: 100%;
					flex: 1;
					position: relative;

					.searchView {
						position: absolute;
						top: 0;
						right: 30rpx;
						z-index: 3;
						@include flex-box-set();
						height: 90rpx;
						color: $brand-theme-color-aux;
					}

					.productView {
						padding: 0 30rpx;

						.proTitle {
							line-height: 90rpx;
							font-size: 30rpx;
							background: #fff;
						}
					}

				}
			}
		}
	}
</style>