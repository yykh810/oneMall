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
            uri:'properties',
            beans: [],
            bean: {id:0,name:'',category:{id:0}},
            pagination:{},
            category:''
        };

        //ViewModel
        var vue = new Vue({
            el: '#workingArea',
            data: data4Vue,
            mounted:function(){ //mounted　表示这个 Vue 对象加载成功了
                this.getCategory(cid);
                this.list(0);
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
                        vue.beans = response.data.list;
                    });
                },
                add: function () {
                    if(!checkEmpty(this.bean.name, "属性名称"))
                        return;
                    var url = this.uri;
                    this.bean.category.id = cid;
                    axios.post(url,this.bean).then(function(response){
                        vue.list(0);
                        vue.bean = {id:0,name:'',category:{id:0}};
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
<div id="workingArea">

    <ol class="breadcrumb">
        <li><a href="admin_category_list">所有分类</a></li>
        <li><a :href="'admin_property_list?cid='+category.id">{{category.name}}</a></li>
        <li class="active">属性管理</li>
    </ol>

    <div class="listDataTableDiv">
        <table class="table table-striped table-bordered table-hover  table-condensed">
            <thead>
            <tr class="success">
                <th>ID</th>
                <th>属性名称</th>
                <th>编辑</th>
                <th>删除</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="bean in beans ">
                <td>{{bean.id}}</td>
                <td>
                    {{bean.name}}
                </td>
                <td>
                    <a :href="'admin_property_edit?id=' + bean.id "><span class="glyphicon glyphicon-edit"></span></a>
                </td>
                <td>
                    <a href="#nowhere"  @click="deleteBean(bean.id)"><span class="glyphicon glyphicon-trash"></span></a>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <%@ include file="../included/adminPage.jsp"%>
    <div class="panel panel-warning addDiv">
        <div class="panel-heading">新增属性</div>
        <div class="panel-body">
            <table class="addTable">
                <tr>
                    <td>属性名称</td>
                    <td><input  @keyup.enter="add"  v-model.trim="bean.name" type="text" class="form-control"></td>
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