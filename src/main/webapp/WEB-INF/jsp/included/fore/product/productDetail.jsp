<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div >
    <div class="productDetailDiv" v-show="showDetail" >
        <div class="productDetailTopPart">
            <a href="#nowhere" class="productDetailTopPartSelectedLink selected">商品详情</a>
            <a href="#nowhere" class="productDetailTopReviewLink" @click="toggle2Review">累计评价 <span class="productDetailTopReviewLinkNumber">{{p.reviewCount}}</span> </a>
        </div>

        <div class="productParamterPart">
            <div class="productParamter">产品参数：</div>
            <div class="productParamterList">
                <span v-for="pv in pvs" >{{pv.property.name}}: {{pv.value | subStringFilter(0,10)}} </span>
            </div>
            <div style="clear:both"></div>
        </div>

        <div class="productDetailImagesPart">
            <img v-for="pi in p.productDetailImages" :src="'img/productDetail/'+pi.id+'.jpg'">
        </div>
    </div>
</div>