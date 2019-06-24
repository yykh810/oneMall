<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<head>
    <%@ include file="../included/adminHeader.jsp" %>
</head>
<body>
    <div><%@ include file="../included/adminNavigator.jsp" %></div>
<script>
    $(function(){
        var pid = getUrlParms("pid");
        var data4Vue = {
            uri:'propertyValues',
            beans: [],
            product: '',
            category:'',
        };

        //ViewModel
        var vue = new Vue({
            el: '#workingArea',
            data: data4Vue,
            mounted:function(){ //mounted　表示这个 Vue 对象加载成功了
                this.getProduct(pid);
                this.list();
            },
            methods: {
                list:function(){
                    var url = "products/"+pid+"/"+ this.uri;
                    axios.get(url).then(function(response) {
                        vue.beans = response.data;
                    });
                },
                getProduct:function(pid){
                    var url = "products/"+pid;
                    axios.get(url).then(function(response) {
                        vue.product = response.data;
                        vue.category = vue.product.category;
                    })
                },
                update:function(bean){
                    var url =  this.uri;
                    var id = bean.id;
                    $("#pvid"+bean.id).css("border","2px solid yellow");
                    axios.put(url,bean).then(function(response) {
                        if(bean.id==response.data.id)
                            $("#pvid"+bean.id).css("border","2px solid green");
                        else
                            $("#pvid"+bean.id).css("border","2px solid red");
                    });
                }
            }

        });
    });

</script>

<div id="workingArea" >
    <ol class="breadcrumb">
        <li><a href="admin_category_list">所有分类</a></li>
        <li><a :href="'admin_product_list?cid='+category.id">{{category.name}}</a></li>
        <li class="active">{{product.name}}</li>
        <li class="active">产品属性管理</li>
    </ol>

    <div class="editPVDiv">
        <div v-for="bean in beans" class="eachPV">
            <span class="pvName" >{{bean.property.name}}</span>
            <span class="pvValue"><input class="pvValue" :id="'pvid'+bean.id" type="text" v-model="bean.value" @keyup="update(bean)"></span>
        </div>
        <div style="clear:both"></div>
    </div>

</div>
    <%@ include file="../included/adminFooter.jsp" %>

</body>
</html>