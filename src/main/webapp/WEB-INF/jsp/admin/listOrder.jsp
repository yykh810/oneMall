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
            uri:'orders',
            beans: [],
            pagination:{}
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
                        vue.beans = response.data.list;
                    });
                },
                showOrderItems: function(order){
                    var id = order.id;
                    $("#orderItemsTR"+id).show();
                },
                jump: function(page){
                    jump(page,vue); //定义在adminHeader.html 中
                },
                jumpByNumber: function(start){
                    jumpByNumber(start,vue);
                },
                deliveryOrder:function(order,e){
                    var url =  "deliveryOrder/"+order.id;
                    axios.put(url).then(function(response) {
                        $(e.target).hide();
                    });
                }
            }
        });

        Vue.filter('formatDateFilter', function (value, formatString) {
            if(null==value)
                return "";
            formatString = formatString || 'YYYY-MM-DD HH:mm:ss';
            return moment(value).format(formatString);
        });
    });

</script>

<div id="workingArea" >
    <h1 class="label label-info" >订单管理</h1>
    <br>
    <br>

    <div class="listDataTableDiv">
        <table class="table table-striped table-bordered table-hover  table-condensed">
            <thead>
            <tr class="success">
                <th>状态</th>
                <th>金额</th>
                <th width="100px">商品数量</th>
                <th width="100px">买家名称</th>
                <th>创建时间</th>
                <th>支付时间</th>
                <th>发货时间</th>
                <th>确认收货时间</th>
                <th width="120px">操作</th>
            </tr>
            </thead>
            <tbody>
            <!-- 在业务上需要一个订单数据产生两行 tr, 此时就不能在 tr上进行 v-for, 而需要用 template 标签 -->
            <template v-for="bean in beans">
                <tr >
                    <td>
                        {{bean.statusDesc}}
                    </td>
                    <td>
                        {{bean.total}}
                    </td>
                    <td>
                        {{bean.totalNumber}}
                    </td>
                    <td>
                        {{bean.uid}}
                    </td>
                    <td>
                        {{bean.createDate | formatDateFilter}}
                    </td>
                    <td>
                        {{bean.payDate | formatDateFilter}}
                    </td>
                    <td>
                        {{bean.deliveryDate | formatDateFilter}}
                    </td>
                    <td>
                        {{bean.confirmDate | formatDateFilter}}
                    </td>
                    <td>
                        <button @click="showOrderItems(bean)" class="orderPageCheckOrderItems btn btn-primary btn-xs">查看详情</button>

                        <button v-if="bean.status=='waitDelivery'" @click="deliveryOrder(bean,$event)" class="btn btn-primary btn-xs">发货</button>
                    </td>
                </tr>
                <tr class="orderPageOrderItemTR"  :id="'orderItemsTR'+bean.id">
                    <td colspan="10" align="center">

                        <div  class="orderPageOrderItem">
                            <table width="800px" align="center" class="orderPageOrderItemTable">
                                <tr v-for="orderItem in bean.orderItems">
                                    <td align="left">
                                        <img width="40px" height="40px" :src="'img/productSingle/'+orderItem.product.firstProductImage.id+'.jpg'">
                                    </td>

                                    <td>
                                        <a :href="'product?product.id='+orderItem.product.id">
                                            <span>{{orderItem.product.name}}</span>
                                        </a>
                                    </td>
                                    <td align="right">

                                        <span class="text-muted">{{orderItem.number}}个</span>
                                    </td>
                                    <td align="right">

                                        <span class="text-muted">单价：￥{{orderItem.product.promotePrice}}</span>
                                    </td>

                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </template>
            </tbody>
        </table>
    </div>
    <%@ include file="../included/adminPage.jsp"%>
</div>
<%@ include file="../included/adminFooter.jsp" %>

</body>
</html>