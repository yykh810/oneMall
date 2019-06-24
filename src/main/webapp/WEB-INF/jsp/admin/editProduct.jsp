<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<head>
    <%@ include file="../included/adminHeader.jsp" %>
</head>
<body>
<div><%@ include file="../included/adminNavigator.jsp" %></div>
<script>
    $(function(){
        var data4Vue = {
            uri: 'products',
            listURL:'admin_product_list',
            bean: '',
            category:''
        };

        //ViewModel
        var vue = new Vue({
            el: '#workingArea',
            data: data4Vue,
            mounted:function(){ //mounted　表示这个 Vue 对象加载成功了
                this.get();
            },
            methods: {
                get:function(){
                    var id = getUrlParms("id");
                    var url = this.uri+"/"+id;
                    axios.get(url).then(function(response) {
                        vue.bean = response.data;
                        vue.category = vue.bean.category;
                    })
                },
                update:function () {
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
                    axios.put(url,vue.bean).then(function(response){
                        location.href=vue.listURL+"?cid="+vue.category.id;
                    });
                }
            }
        });
    });
</script>

<div id="workingArea">

    <ol class="breadcrumb">
        <li><a href="admin_category_list">所有分类</a></li>
        <li><a :href="'admin_product_list?cid='+category.id">{{category.name}}</a></li>
        <li class="active">产品管理</li>
    </ol>

    <div class="panel panel-warning editDiv">
        <div class="panel-heading">编辑产品</div>
        <div class="panel-body">
            <table class="editTable">
                <tr>
                    <td>产品名称</td>
                    <td><input  @keyup.enter="update" v-model.trim="bean.name" type="text" class="form-control"></td>
                </tr>
                <tr>
                    <td>产品小标题</td>
                    <td><input  @keyup.enter="update" v-model.trim="bean.subTitle" type="text"
                                class="form-control"></td>
                </tr>
                <tr>
                    <td>原价格</td>
                    <td><input  @keyup.enter="update" v-model.trim="bean.originalPrice"  type="text"
                                class="form-control"></td>
                </tr>
                <tr>
                    <td>优惠价格</td>
                    <td><input  @keyup.enter="update" v-model.trim="bean.promotePrice" type="text"
                                class="form-control"></td>
                </tr>
                <tr>
                    <td>库存</td>
                    <td><input  @keyup.enter="update" v-model.trim="bean.stock"  type="text"
                                class="form-control"></td>
                </tr>
                <tr class="submitTR">
                    <td colspan="2" align="center">
                        <input type="hidden" name="id"   v-model.trim="bean.id" >
                        <a href="#nowhere" class="btn btn-success" @click="update">提 交</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
<%@ include file="../included/adminFooter.jsp" %>

</body>
</html>