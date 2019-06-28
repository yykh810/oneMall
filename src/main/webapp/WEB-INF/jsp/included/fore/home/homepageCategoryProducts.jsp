<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div >
    <div class="homepageCategoryProducts">
        <div class="eachHomepageCategoryProducts" v-for="c in categories">
            <div class="left-mark"></div>
            <span class="categoryTitle">{{c.category.name}}</span>
            <br>
            <div class="productItem"  v-for="p,index in c.products" v-if="index<5" >
                <a :href="'product?pid='+p.id">
                    <img width="100px" :src="'img/productSingle_middle/'+p.firstProductImage.id+'.jpg'">
                </a>
                <a class="productItemDescLink" :href="'product?pid='+p.id">
                    <span class="productItemDesc">[热销]
                    {{p.name | subStringFilter(0,20)}}
                    </span>
                </a>
                    <span class="productPrice">
                    {{p.promotePrice | formatMoneyFilter}}
                    </span>
            </div>
            <div style="clear:both"></div>
        </div>
        <img id="endpng" class="endpng" src="img/site/end.png">
    </div>
</div>