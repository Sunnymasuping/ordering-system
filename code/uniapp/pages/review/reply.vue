<template>
	<view class="reply-board">
		<view class="reply-list">
			<view v-for="(reply, index) in sortedReplies" :key="reply.pid"
				:class="['reply-card', reply.cid ? '' : 'merchant-reply']">
				<view class="reply-header">
					<text class="reply-time">{{ reply.ptime }}</text>
				</view>
				<view class="reply-body">
					<text class="reply-content">{{ reply.pcontent }}</text>
				</view>
				<view class="reply-footer">
					<text class="reply-user">
						<text v-if="!reply.cid" class="merchant-tag">商家回复</text>
						{{ reply.cid||''}}
					</text>
				</view>
			</view>
		</view>
		<view class="reply-input">
			<view class="input-area">
				<input type="text" v-model="newReplyContent" placeholder="输入回复内容" />
			</view>
			<button @click="submitReply">提交回复</button>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				review: {}, // 当前的留言
				replies: [], // 回复留言列表
				newReplyContent: '' // 新回复内容
			};
		},
		computed: {
			sortedReplies() {
				// 将商家回复置顶
				const merchantReplies = this.replies.filter(reply => !reply.cid);
				const userReplies = this.replies.filter(reply => reply.cid);
				return [...merchantReplies, ...userReplies];
			}
		},
		methods: {
			fetchReplies(rid) {
				uni.request({
					url: `http://localhost:8077/selectAllReplyByRid?rid=${rid}`,
					method: 'GET',
					success: (res) => {
						if (res.statusCode === 200) {
							this.replies = res.data;
						} else {
							console.error('Failed to fetch replies:', res);
						}
					},
					fail: (err) => {
						console.error('Request error:', err);
					}
				});
			},
			submitReply() {
				const cid = uni.getStorageSync('cid'); // 从缓存中获取用户ID
				const now = new Date();
				const ptime =
					`${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-${String(now.getDate()).padStart(2, '0')}`;

				const newReply = {
					cid: cid,
					rid: this.review.rid,
					ptime: ptime,
					pcontent: this.newReplyContent,
					aid: null
				};

				uni.request({
					url: 'http://localhost:8077/insertReply',
					method: 'POST',
					data: newReply,
					success: (res) => {
						if (res.statusCode === 200) {
							uni.showToast({
								title: '回复成功',
								icon: 'success'
							});
							this.newReplyContent = ''; // 清空输入框
							this.fetchReplies(this.review.rid); // 重新获取回复列表
						} else {
							console.error('Failed to submit reply:', res);
							uni.showToast({
								title: '回复失败',
								icon: 'none'
							});
						}
					},
					fail: (err) => {
						console.error('Request error:', err);
						uni.showToast({
							title: '请求失败',
							icon: 'none'
						});
					}
				});
			}
		},
		onLoad(options) {
			if (options.rid) {
				this.review = {
					rid: options.rid,
					rscore: options.rscore,
					rcontent: options.rcontent,
					rtime: options.rtime,
					cid: options.cid
				};
				this.fetchReplies(options.rid);
			} else {
				console.error('No RID received in options');
			}
		}
	};
</script>

<style lang="scss">
	.reply-board {
		padding: 20px;
	}

	.reply-card {
		background-color: #fff;
		padding: 15px;
		margin-bottom: 10px;
		border-radius: 10px;
		box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	}

	.merchant-reply {
		background-color: #fff9e6;
	}

	.reply-header,
	.reply-footer {
		display: flex;
		justify-content: space-between;
		margin-bottom: 10px;
	}

	.reply-body {
		margin-bottom: 10px;
	}

	.reply-time,
	.reply-user {
		color: #999;
	}

	.reply-input {
		position: fixed;
		bottom: 0;
		width: 100%;
		background-color: #ffffff;
		padding: 20rpx;
		border-top: 1rpx solid #e0e0e0;
		box-shadow: 0 -10rpx 30rpx rgba(0, 0, 0, 0.1);
		display: flex;
		align-items: center;
	}

	.input-area {
		flex: 1;
		display: flex;
		align-items: center;
	}

	.input-area input {
		flex: 1;
		height: 80rpx;
		padding: 0 20rpx;
		border: 1rpx solid #e0e0e0;
		border-radius: 40rpx;
		font-size: 28rpx;
		outline: none;
	}

	button {
		margin-left: 20rpx;
		height: 80rpx;
		padding: 0 30rpx;
		background-color: #007aff;
		color: #ffffff;
		border: none;
		border-radius: 40rpx;
		font-size: 28rpx;
		cursor: pointer;
		outline: none;
	}

	button:active {
		background-color: #005bb5;
	}
</style>