<template>
	<view class="profile-container">
		<view class="profile-card">
			<view class="profile-header">
				<image :src="customer.cavatar || defaultAvatar" class="avatar" />
				<view class="name">{{ customer.cname }}</view>
			</view>
			<view class="profile-info">
				<view class="info-item">性别: {{ customer.csex }}</view>
				<view class="info-item">生日: {{ customer.cbirth }}</view>
				<view class="info-item">电话: {{ customer.cphone }}</view>
			</view>
			<u-button type="primary" @click="navigateToEdit">编辑个人信息</u-button>
			<view>
				<u-button type="primary" @click="navigateToReview">评价店铺</u-button>
			</view>
			<view>
				<u-button type="primary" @click="navigateToMyReview">查看我的评价</u-button>
			</view>
			<view>
				<u-button type="danger" @click="navigateToLogin">退出登录</u-button>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				customer: {
					cid: '',
					cname: '',
					csex: '',
					cbirth: '',
					cphone: '',
					cavatar: ''
				},
				defaultAvatar: '/static/logo.png' // 默认头像路径
			};
		},
		onLoad() {
			const cid = uni.getStorageSync('cid');
			this.getCustomerData(cid);
		},
		methods: {
			getCustomerData(cid) {
				uni.request({
					url: `http://localhost:8077/findcustomerbycid?cid=${cid}`,
					method: 'GET',
					success: (res) => {
						if (res.statusCode === 200 && res.data.length > 0) {
							this.customer = res.data[0];
						} else {
							uni.showToast({
								title: '获取数据失败',
								icon: 'error'
							});
						}
					}
				});
			},
			navigateToEdit() {
				uni.navigateTo({
					url: '/pages/edit/edit' // 编辑个人信息页面的路径
				});
			},
			navigateToReview() {
				uni.navigateTo({
					url: '/pages/review/review'
				});
			},
			navigateToMyReview() {
				uni.navigateTo({
					url: '/pages/myreview/myreview' // 跳转到查看我的评价页面
				});
			},
			navigateToLogin() {
				// 清除缓存中的数据
				try {
					uni.clearStorageSync();
				} catch (e) {
					console.error('清除缓存数据时出错:', e);
				}

				// 跳转到登录页面
				uni.redirectTo({
					url: '/pages/login/login'
				});
			}
		}
	};
</script>

<style>
	.profile-container {
		display: flex;
		justify-content: center;
		align-items: center;
		height: 100vh;
		background-color: #f5f5f5;
	}

	.profile-card {
		background-color: #fff;
		padding: 20px;
		border-radius: 10px;
		box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
		width: 80%;
		max-width: 400px;
		text-align: center;
	}

	.profile-header {
		display: flex;
		flex-direction: column;
		align-items: center;
		margin-bottom: 20px;
	}

	.avatar {
		width: 100px;
		height: 100px;
		border-radius: 50%;
		object-fit: cover;
	}

	.name {
		font-size: 24px;
		font-weight: bold;
		margin-top: 10px;
	}

	.profile-info {
		text-align: left;
		margin-bottom: 20px;
	}

	.info-item {
		font-size: 16px;
		color: #666;
		margin-bottom: 10px;
	}

	.u-button {
		width: 100%;
		margin-top: 20px;
	}
</style>