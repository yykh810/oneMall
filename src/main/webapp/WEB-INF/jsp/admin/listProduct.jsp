<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<head>
    <%@ include file="../included/adminHeader.jsp" %>
</head>
<body>
    <div><%@ include file="../included/adminNavigator.jsp" %></div>
<script>
    $(function(){
        var cid = getUrlParms("cid");
        var data4Vue = {
            uri:'products',
            beans: [],
            bean: {id:0,name:'','subTitle':'','originalPrice':99.98,'promotePrice':19.98,'stock':99,category:{'id':0}},
            pagination:{},
            category:''
        };

        //ViewModel
        var vue = new Vue({
            el: '#workingArea',
            data: data4Vue,
            mounted:function(){ //mounted　表示这个 Vue 对象加载成功了
                this.list(0);
                this.getCategory(cid);
            },
            methods: {
                getCategory:function(cid){
                    var url = "categories/"+cid;
                    axios.get(url).then(function(response) {
                        vue.category = response.data;
                    })
                },
                list:function(start){
                    var url =  "categories/"+cid+"/"+this.uri+"?start="+start;
                    axios.get(url).then(function(response) {
                        vue.pagination = response.data;
                        vue.beans = response.data.list  ;
                    });
                },
                add: function () {
                    if(!checkEmpty(this.bean.name, "产品名称"))
                        return;
                    if (!checkEmpty(this.bean.subTitle, "小标题"))
                        return;
                    if (!checkNumber(this.bean.originalPrice, "原价格"))
                        return;
                    if (!checkNumber(this.bean.promotePrice, "优惠价格"))
                        return;
                    if (!checkInt(this.bean.stock, "库存"))
                        return;

                    var url = this.uri;
                    this.bean.category.id=cid;
                    axios.post(url,this.bean).then(function(response){
                        vue.list(0);
                        vue.bean =  {id:0,name:'','subTitle':'','originalPrice':99.98,'promotePrice':19.98,'stock':99,category:{'id':0}};
                    });
                },
                deleteBean: function (id) {
                    if(!checkDeleteLink())
                        return;
                    var url = this.uri+"/"+id;
                    axios.delete(url).then(function(response){
                        if(0!=response.data.length)
                            alert(response.data);
                        else
                            vue.list(0);
                    });
                },
                jump: function(page){
                    jump(page,vue); //定义在adminHeader.html 中
                },
                jumpByNumber: function(start){
                    jumpByNumber(start,vue);
                }
            }

        });
    });

</script>
<div id="workingArea" >
    <ol class="breadcrumb">
        <li><a href="admin_category_list">所有分类</a></li>
        <li><a :href="'admin_product_list?cid='+category.id">{{category.name}}</a></li>
        <li class="active">产品管理</li>
    </ol>

    <div class="listDataTableDiv">
        <table class="table table-striped table-bordered table-hover table-condensed">
            <thead>
            <tr class="success">
                <th>ID</th>
                <th>图片</th>
                <th>产品名称</th>
                <th>产品小标题</th>
                <th width="53px">原价格</th>
                <th width="80px">优惠价格</th>
                <th width="80px">库存数量</th>
                <th width="80px">图片管理</th>
                <th width="80px">设置属性</th>
                <th>编辑</th>
                <th>删除</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="bean in beans ">
                <td>{{bean.id}}</td>
                <td>
                    <img v-if="null != bean.firstProductImage" width="40px" :src="'img/productSingle/'+bean.firstProductImage.id+'.jpg'">
                </td>
                <td>{{bean.name}}</td>
                <td>{{bean.subTitle}}</td>
                <td>{{bean.originalPrice}}</td>
                <td>{{bean.promotePrice}}</td>
                <td>{{bean.stock}}</td>

                <td>
                    <a :href="'admin_productImage_list?pid=' + bean.id "><span class="glyphicon glyphicon-picture"></span></a>
                </td>
                <td>
                    <a :href="'admin_propertyValue_edit?pid=' + bean.id "><span class="glyphicon glyphicon-th-list"></span></a>
                </td>

                <td>
                    <a :href="'admin_product_edit?id=' + bean.id "><span class="glyphicon glyphicon-edit"></span></a>
                </td>
                <td>
                    <a href="#nowhere"  @click="deleteBean(bean.id)"><span class="   glyphicon glyphicon-trash"></span></a>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
<%@ include file="../included/adminPage.jsp"%>
    <div class="panel panel-warning addDiv">
        <div class="panel-heading">新增产品</div>
        <div class="panel-body">
            <table class="addTable">
                <tr>
                    <td>产品名称</td>
                    <td><input  @keyup.enter="add" v-model.trim="bean.name" type="text" class="form-control"></td>
                </tr>
                <tr>
                    <td>产品小标题</td>
                    <td><input  @keyup.enter="add" v-model.trim="bean.subTitle" type="text"
                                class="form-control"></td>
                </tr>
                <tr>
                    <td>原价格</td>
                    <td><input  @keyup.enter="add" v-model.trim="bean.originalPrice"  type="text"
                                class="form-control"></td>
                </tr>
                <tr>
                    <td>优惠价格</td>
                    <td><input  @keyup.enter="add" v-model.trim="bean.promotePrice" type="text"
                                class="form-control"></td>
                </tr>
                <tr>
                    <td>库存</td>
                    <td><input  @keyup.enter="add" v-model.trim="bean.stock"  type="text"
                                class="form-control"></td>
                </tr>

                <tr class="submitTR">
                    <td colspan="2" align="center">
                        <a href="#nowhere"  @click="add" class="btn btn-success">提交</a>
                    </td>
                </tr>
            </table>

        </div>
    </div>
</div>
<%@ include file="../included/adminFooter.jsp" %>

</body>
</html>