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
            uri:'categories',
            pagination:{},
            beans: [],
            bean: { id: 0, name: ''},
            file: null
        };

        //ViewModel
        var vue = new Vue({
            el: '#workingArea',
            data: data4Vue,
            mounted:function(){ //mounted　表示这个 Vue 对象加载成功了
                this.list(0);
            },
            methods: {
                list:function(start){
                    var url =  this.uri+ "?start="+start;
                    axios.get(url).then(function(response) {
                        vue.pagination = response.data;
                        vue.beans = response.data.list	;
                    });
                },
                deleteBean: function (id) {
                    if(!checkDeleteLink())
                        return;
                    var url = this.uri+"/"+id;
                    axios.delete(url).then(function(response){
                        if(0!=response.data.length){
                            alert(response.data);
                        }
                        else{
                            vue.list(0);
                        }
                    });
                },
                getFile: function (event) {
                    this.file = event.target.files[0];
                },
                add: function () {
                    if(!checkEmpty(this.bean.name, "分类名称"))
                        return;
                    if(!checkEmpty(this.file, "分类图片"))
                        return;
                    var url = this.uri;
                    //axios.js 上传文件要用 formData 这种方式
                    var formData = new FormData();
                    formData.append("image", this.file);
                    formData.append("name", this.bean.name);
                    axios.post(url,formData).then(function(response){
                        vue.list(0);
                        vue.bean = { id: 0, name: '', hp: '0'};
                        $("#categoryPic").val('');
                        vue.file = null;
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
    <h1 class="label label-info" >分类管理</h1>
    <br>
    <br>
    <div class="listDataTableDiv">
        <table class="table table-striped table-bordered table-hover  table-condensed">
            <thead>
            <tr class="success">
                <th>ID</th>
                <th>图片</th>
                <th>分类名称</th>
                <th>属性管理</th>
                <th>产品管理</th>
                <th>编辑</th>
                <th>删除</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="bean in beans ">
                <td>{{bean.id}}</td>
                <td>
                    <img height="40px"  :src="'img/category/'+bean.id+'.jpg'">
                </td>
                <td>
                    {{bean.name}}
                </td>
                <td>
                    <a :href="'admin_property_list?cid=' + bean.id "><span class="glyphicon glyphicon-th-list"></span></a>
                </td>
                <td>
                    <a :href="'admin_product_list?cid=' + bean.id "><span class="glyphicon glyphicon-shopping-cart"></span></a>
                </td>
                <td>
                    <a :href="'admin_category_edit?id=' + bean.id "><span class="glyphicon glyphicon-edit"></span></a>
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
        <div class="panel-heading">新增分类</div>
        <div class="panel-body">
            <table class="addTable">
                <tr>
                    <td>分类名称</td>
                    <td><input  @keyup.enter="add" v-model.trim="bean.name" type="text" class="form-control"></td>
                </tr>
                <tr>
                    <td>分类图片</td>
                    <td>
                        <input id="categoryPic" accept="image/*" type="file" name="image" @change="getFile($event)" />
                    </td>
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