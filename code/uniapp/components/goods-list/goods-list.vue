<template>
  <view class="goodsLayout">
    <view class="wrapper">
      <view class="title">共{{ buyNum }}件商品</view>
      <view class="list">
        <view class="row" v-for="dish in carsList" :key="dish.id">
          <view class="item">
            <image :src="dish.picture" mode="aspectFill" class="img"></image>
            <view class="name">{{ dish.dishName }}</view>
          </view>
          <view class="quantity">x{{ dish.numvalue }}</view>
          <view class="price">￥{{ dish.price }}</view>
        </view>
      </view>
      <view class="total">
        合计<text class="big">￥{{ totalPrice }}</text>
      </view>
    </view>
  </view>
</template>

<script>
import { mapGetters } from 'vuex';
export default {
  name: "goods-list",
  computed: {
    ...mapGetters(['carsList', 'totalPrice', 'buyNum'])
  },
  data() {
    return {};
  }
}
</script>

<style lang="scss">
.goodsLayout {
  .wrapper {
    background: #fff;
    padding: 30rpx;
    margin-bottom: 25rpx;
    border-radius: 15rpx;
    .title {
      font-size: 38rpx;
    }
    .list {
      .row {
        display: flex;
        align-items: center;
        padding: 25rpx 0;
        border-bottom: 1px solid #eee;
        .item {
          display: flex;
          align-items: center;
          .img {
            width: 100px; /* 调整图片宽度 */
            height: 100px; /* 调整图片高度 */
            border-radius: 10px;
            margin-right: 20px;
          }
          .name {
            font-size: 30rpx;
            white-space: nowrap; /* 不换行显示 */
            overflow: hidden; /* 超出部分隐藏 */
            text-overflow: ellipsis; /* 超出部分显示省略号 */
          }
        }
        .quantity {
          margin-left: auto; /* 将数量显示移到最右边 */
        }
        .price {
          margin-left: 20px; /* 设置价格与数量之间的间距 */
          font-weight: bold;
          font-size: 34rpx;
          color: #000;
        }
      }
    }
    .total {
      padding: 30rpx 0;
      text-align: right;
      font-size: 30rpx;
      color: $text-font-color-3;
      .big {
        font-size: 36rpx;
        font-weight: bold;
        color: #000;
      }
    }
  }
}
</style>
