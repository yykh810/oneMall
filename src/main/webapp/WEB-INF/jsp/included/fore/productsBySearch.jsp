<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div class >
    <div class="searchProducts">
        <div class="productUnit"  v-for="p in products" >
            <a :href="'product?pid='+p.id">
                <img class="productImage" :src="'img/productSingle/'+p.firstProductImage.id+'.jpg'">
            </a>
            <span class="productPrice">
                {{p.promotePrice|formatMoneyFilter}}
            </span>
            <a class="productLink" :href="'product?pid='+p.id">
                {{p.name|subStringFilter(0,50)}}
            </a>
            <a  class="tmallLink" :href="'product?pid='+p.id">天猫专卖</a>
            <div class="show1 productInfo">
                <span class="monthDeal ">月成交 <span class="productDealNumber">{{p.saleCount}}笔</span></span>
                <span class="productReview">评价<span class="productReviewNumber">{{p.reviewCount}}</span></span>
                <span class="wangwang"><img src="img/site/wangwang.png"></span>
            </div>
        </div>
        <div v-if="0 == products.length" class="noMatch">没有满足条件的产品</div>
        <div style="clear:both"></div>
    </div>
</div>