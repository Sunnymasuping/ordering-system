<template>
	<view class="container">
		<view class="card">
			<u-form @submit="handleSubmit">
				<u-form-item label="用户ID">
					<u-input v-model="user.cid" placeholder="请输入用户ID"></u-input>
				</u-form-item>
				<u-form-item label="用户名">
					<u-input v-model="user.cname" placeholder="请输入用户名"></u-input>
				</u-form-item>
				<u-form-item label="性别">
					<u-input v-model="user.csex" placeholder="请输入性别:男/女"></u-input>
				</u-form-item>
				<u-form-item label="出生日期">
					<u-input v-model="user.cbirth" placeholder="2001-01-01"></u-input>
				</u-form-item>
				<u-form-item label="手机号">
					<u-input v-model="user.cphone" placeholder="请输入手机号"></u-input>
				</u-form-item>
				<u-form-item label="密码">
					<u-input v-model="user.cpwd" type="password" placeholder="请输入密码"></u-input>
				</u-form-item>
				<u-button type="primary" form-type="submit" @click="handleSubmit">注册</u-button>
			</u-form>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				user: {
					cid: '',
					cname: '',
					csex: '',
					cbirth: '',
					cphone: '',
					cpwd: '',
					cstatus: '待审核'
				}
			};
		},
		methods: {
			handleSubmit() {
				console.log(this.user)
				// 提交注册表单
				uni.request({
					url: 'http://localhost:8077/insertcustomer',
					method: 'POST',
					data: this.user,
					success: (res) => {
						if (res.statusCode === 200) {
							uni.showToast({
								title: '注册成功，请等待审核',
								icon: 'success'
							});
							uni.navigateTo({
							    url: '/pages/login/login'
							});
						} else {
							uni.showToast({
								title: '注册失败',
								icon: 'none'
							});
						}
					},
					fail: () => {
						uni.showToast({
							title: '请求失败',
							icon: 'none'
						});
					}
				});
			}
		}
	};
</script>

<style>
	.container {
		padding: 20px;
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
</style>