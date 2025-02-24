<template>
	<view class="container">
		<view class="card">
			<text class="title">用户登录</text>
			<input v-model="cid" type="id" placeholder="请输入账号" class="input" />
			<input v-model="cpwd" type="password" placeholder="请输入密码" class="input" />
			<button @click="login" class="button">登录</button>
			<navigator url="/pages/register/register" class="register-link">前往注册</navigator>
		</view>
	</view>
</template>


<script>
	export default {
		data() {
			return {
				cid: '',
				cpwd: ''
			};
		},
		methods: {
			login() {
				console.log('账号:', this.cid);
				console.log('密码:', this.cpwd);

				const baseUrl = "http://localhost:8077";

				uni.request({
					url: baseUrl + '/login/customerlogin',
					method: "POST",
					header: {
						'content-type': 'application/json' // 设置请求头为 JSON 格式
					},
					data: {
						cid: this.cid,
						cpwd: this.cpwd
					},
					success: (res) => {
						const data = res.data;
						if (data === 1) {
							uni.showToast({
								title: "登录成功"
							})
							uni.switchTab({
								url: '/pages/index/index'
							});
							// 存储用户的数据到 storage
							uni.setStorageSync('cid', this.cid);
						} else if (data === 2) {
							uni.showToast({
								icon: "none",
								title: '账号或密码错误，新用户请等待审核'
							});
						} else {
							uni.showToast({
								icon: "none",
								title: '登录失败，请稍后重试'
							});
						}
					},
					fail: (error) => {
						console.error('登录失败:', error);
						uni.showToast({
							icon: "none",
							title: '登录失败，请稍后重试'
						});
					}
				});
			}
		}
	};
</script>

<style>
	.container {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		padding: 15px;
		
	}

	.card {
		width: 90%;
		max-width: 400px;
		padding: 20px;
		box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
		border-radius: 10px;
		background-color: #fff;
		display: flex;
		flex-direction: column;
		align-items: center;
	}

	.title {
		font-size: 25px;
		font-weight: bold;
		margin-bottom: 20px;
		color: #333;
	}

	.input {
		width: 100%;
		padding: 10px;
		margin-bottom: 20px;
		border: 1px solid #ccc;
		border-radius: 5px;
		font-size: 16px;
	}

	.button {
		width: 70%;
		padding: 10px;
		background-color: #19be6b;
		color: #fff;
		border: none;
		border-radius: 5px;
		font-size: 35rpx;
		cursor: pointer;
		text-align: center;
	}

	.button:hover {
		background-color: #17a45b;
	}

	.register-link {
		margin-top: 20px;
		color: cornflowerblue;
		font-size: 16px;
		text-decoration: underline;
		cursor: pointer;
	}
</style>