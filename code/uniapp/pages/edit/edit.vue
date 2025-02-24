<template>
	<view class="container">
		<view class="profile-card">
			<u-form ref="form" :model="customer">
				<u-form-item label="头像">
					<view @click="chooseImage" class="avatar-container">
						<image :src="cavatar || defaultAvatar" class="avatar" />
					</view>
				</u-form-item>
				<u-form-item label="姓名">
					<u-input v-model="customer.cname" placeholder="请输入姓名"></u-input>
				</u-form-item>
				<u-form-item label="性别">
					<u-input v-model="customer.csex" placeholder="请输入性别:男/女"></u-input>
				</u-form-item>
				<u-form-item label="生日">
					<u-input v-model="customer.cbirth" placeholder="请输入生日:2001-01-01"></u-input>
				</u-form-item>
				<u-form-item label="电话">
					<u-input v-model="customer.cphone" placeholder="请输入电话"></u-input>
				</u-form-item>
				<u-form-item label="修改密码">
					<u-input v-model="customer.cpwd" placeholder="请输入新密码"></u-input>
				</u-form-item>
				<u-button type="primary" @click="updateProfile">保存</u-button>
			</u-form>
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
					cpwd: '',
					csex: '',
					cbirth: '',
					cphone: ''
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
			chooseImage() {
				uni.chooseImage({
					count: 1,
					sizeType: ['compressed'],
					sourceType: ['album', 'camera'],
					success: (res) => {
						const tempFilePath = res.tempFilePaths[0];
						this.uploadImage(tempFilePath);
					}
				});
			},

			updateProfile() {
				console.log(this.customer)
				uni.request({
					url: 'http://localhost:8077/insertcustomer',
					method: 'POST',
					data: this.customer,
					success: (res) => {
						if (res.statusCode === 200) {
							uni.showToast({
								title: '更新成功',
								icon: 'success'
							});
							uni.navigateBack();
						} else {
							uni.showToast({
								title: '更新失败',
								icon: 'error'
							});
						}
					}
				});
			},
		}
	};
</script>

<style>
	.container {
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

	.avatar-container {
		display: flex;
		align-items: center;
		justify-content: center;
		flex-direction: column;
	}

	.avatar {
		width: 100px;
		height: 100px;
		border-radius: 50%;
		object-fit: cover;
		margin-bottom: 10px;
	}

	.u-button {
		width: 100%;
		margin-top: 20px;
	}
</style>