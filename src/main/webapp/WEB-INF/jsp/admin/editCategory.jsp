<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<head>
    <%@ include file="../included/adminHeader.jsp" %>
</head>
<body>
    <div><%@ include file="../included/adminNavigator.jsp" %></div>
<script>
    $(function(){
        var data4Vue = {
            uri:'categories',
            listURL:'admin_category_list',
            bean: { id: 0, name: '', hp: '0'},
            file:''
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
                    })
                },
                update:function () {
                    if(!checkEmpty(this.bean.name, "分类名称"))
                        return;
                    var url = this.uri+"/"+this.bean.id;

                    //axios.js 上传文件要用 formData 这种方式
                    var formData = new FormData();
                    formData.append("image", this.file);
                    formData.append("name", this.bean.name);
                    axios.put(url,formData).then(function(response){
                        location.href=vue.listURL;
                    });
                },
                getFile: function (event) {
                    this.file = event.target.files[0];
                }
            }
        });
    });

</script>
<div id="workingArea">

    <ol class="breadcrumb">
        <li><a href="admin_category_list">所有分类</a></li>
        <li class="active">编辑分类</li>
    </ol>

    <div class="panel panel-warning editDiv">
        <div class="panel-heading">编辑分类</div>
        <div class="panel-body">
            <table class="editTable">
                <tr>
                    <td>分类名称</td>
                    <td><input  @keyup.enter="update" v-model.trim="bean.name" type="text" class="form-control"></td>
                </tr>
                <tr>
                    <td>分类图片</td>
                    <td>
                        <input id="categoryPic" accept="image/*" type="file" name="image" @change="getFile($event)" />
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