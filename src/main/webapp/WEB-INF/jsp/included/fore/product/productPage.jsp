<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div>
    <script>
        $(function(){
            var pid = getUrlParms("pid");
            var data4Vue = {
                uri:'foreproduct',
                p:'',
                category:null,
                firstProductImage:null,
                pvs:[],
                reviews:[],
                showDetail:true,
                showReview:false,
                user:{name:'', password:''}
            };
            //ViewModel
            var vue = new Vue({
                el: '#workingArea',
                data: data4Vue,
                mounted:function(){ //mounted　表示这个 Vue 对象加载成功了
                    linkDefaultActions();
                    this.load();
                },
                methods: {
                    load:function(){
                        var url =  this.uri+"/"+pid;
                        axios.get(url).then(function(response) {
                            var result = response.data;
                            vue.p=result.data.product;
                            vue.pvs=result.data.pvs;
                            vue.reviews=result.data.reviews;
                            vue.category = vue.p.category;
                            vue.firstProductImage = vue.p.firstProductImage;
                            vue.$nextTick(function(){
                                imgAndInfoPageRegisterListeners(vue);
                            })
                        });

                    },
                    toggle2Detail:function(){
                        this.showDetail=true;
                        this.showReview=false;
                    },
                    toggle2Review:function(){
                        this.showDetail=false;
                        this.showReview=true;
                    }
                }
            });

        });
    </script>
    <title>模仿天猫官网 -- {{p.name}}</title>
    <div class="categoryPictureInProductPageDiv">
        <img v-if="category != null" class="categoryPictureInProductPage" :src="'img/category/'+category.id+'.jpg'">
    </div>
    <div class="productPageDiv">
        <%@ include file="imgAndInfo.jsp" %>
        <%@ include file="productReview.jsp" %>
        <%@ include file="productDetail.jsp" %>
    </div>
</div>