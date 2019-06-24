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
            uri:'properties',
            listURL:'admin_property_list',
            bean: { id: 0, name: '', hp: '0'},
            bean:'',
            category:""
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
                    if(!checkEmpty(this.bean.name, "属性名称"))
                        return;
                    var url = this.uri;
                    axios.put(url,vue.bean).then(function(response){
                        location.href=vue.listURL+"?cid="+vue.category.id;
                    });
                },
            }
        });
    });

</script>
<div id="workingArea">

    <ol class="breadcrumb">
        <li><a href="admin_category_list">所有分类</a></li>
        <li><a :href="'admin_property_list?cid='+category.id">{{category.name}}</a></li>
        <li class="active">属性管理</li>
    </ol>

    <div class="panel panel-warning editDiv">
        <div class="panel-heading">编辑属性</div>
        <div class="panel-body">
            <table class="editTable">
                <tr>
                    <td>分类名称</td>
                    <td><input  @keyup.enter="update" v-model.trim="bean.name" type="text" class="form-control"></td>
                </tr>
                <tr>
                    <td>属性名称</td>
                    <td>
                        <input  @keyup.enter="update"  v-model.trim="bean.name" type="text" class="form-control" />
                    </td>
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