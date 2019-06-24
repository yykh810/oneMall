<%@ page  contentType="text/html; charset=UTF-8"
          pageEncoding="UTF-8"%>
<script src="js/jquery/2.0.0/jquery.min.js"></script>
<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
<script src="js/vue/2.5.16/vue.js"></script>
<script src="js/axios/0.17.1/axios.min.js"></script>
<script src="js/moment/2.22.2/moment.js"></script> <!-- vue.js 格式化日期用的 -->
<link href="css/back/style.css" rel="stylesheet">

<script>
    //判断是否为空
    function checkEmpty(value,text){

        if(null==value || value.length==0){
            alert(text+ "不能为空");
            return false;
        }
        return true;
    }

    //获取地址栏参数的函数
    function getUrlParms(para){
        var search=location.search; //页面URL的查询部分字符串
        var arrPara=new Array(); //参数数组。数组单项为包含参数名和参数值的字符串，如“para=value”
        var arrVal=new Array(); //参数值数组。用于存储查找到的参数值

        if(search!=""){
            var index=0;
            search=search.substr(1); //去除开头的“?”
            arrPara=search.split("&");

            for(i in arrPara){
                var paraPre=para+"="; //参数前缀。即参数名+“=”，如“para=”
                if(arrPara[i].indexOf(paraPre)==0&& paraPre.length<arrPara[i].length){
                    arrVal[index]=decodeURI(arrPara[i].substr(paraPre.length)); //顺带URI解码避免出现乱码
                    index++;
                }
            }
        }

        if(arrVal.length==1){
            return arrVal[0];
        }else if(arrVal.length==0){
            return null;
        }else{
            return arrVal;
        }
    }

    //判断是否数字 (小数和整数)
    function checkNumber(value, text){

        if(value.length==0){
            alert(text+ "不能为空");
            return false;
        }
        if(isNaN(value)){
            alert(text+ "必须是数字");
            return false;
        }
        return true;
    }
    //判断是否整数
    function checkInt(value, text){

        if(value.length==0){
            alert(text+ "不能为空");
            return false;
        }
        if(parseInt(value)!=value){
            alert(text+ "必须是整数");
            return false;
        }
        return true;
    }

    //确实是否要删除
    function checkDeleteLink(){
        var confirmDelete = confirm("确认要删除");
        if(confirmDelete)
            return true;
        return false;
    }
    //跳转函数
    function jump(page,vue){
        if('first'== page && !vue.pagination.isFirstPage)
            vue.list(0);

        else if('pre'== page &&	vue.pagination.hasPreviousPage )
            vue.list(vue.pagination.pageNum-1);

        else if('next'== page && vue.pagination.hasNextPage )
            vue.list(vue.pagination.pageNum+1);

        else if('last'== page && !vue.pagination.isLastPage )
            vue.list(vue.pagination.pages);
    }
    //跳转函数
    function jumpByNumber(start,vue){
        if(start!=vue.pagination.pageNum)
            vue.list(start);
    }
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
