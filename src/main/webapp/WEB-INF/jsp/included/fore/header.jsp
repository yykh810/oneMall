<%@ page  contentType="text/html; charset=UTF-8"
          pageEncoding="UTF-8"%>
<script src="js/jquery/2.0.0/jquery.min.js"></script>
<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
<script src="js/vue/2.5.16/vue.js"></script>
<script src="js/axios/0.17.1/axios.min.js"></script>
<script src="js/moment/2.22.2/moment.js"></script>
<link href="css/fore/style.css" rel="stylesheet">
<script>
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

    function formatMoney(num){
        num = new String(num);
        num = num.toString().replace(/\$|\,/g,'');
        if(isNaN(num))
            num = "0";
        sign = (num == (num = Math.abs(num)));
        num = Math.floor(num*100+0.50000000001);
        cents = num%100;
        num = Math.floor(num/100).toString();
        if(cents<10)
            cents = "0" + cents;
        for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
            num = num.substring(0,num.length-(4*i+3))+','+
                num.substring(num.length-(4*i+3));
        return (((sign)?'':'-') + num + '.' + cents);
    }

    function checkEmpty(id, name){
        var value = $("#"+id).val();
        if(value.length==0){
            $("#"+id)[0].focus();
            return false;
        }
        return true;
    }

    function linkDefaultActions(){
        $("span.leaveMessageTextareaSpan").hide();
        $("img.leaveMessageImg").click(function(){
            $(this).hide();
            $("span.leaveMessageTextareaSpan").show();
            $("div.orderItemSumDiv").css("height","100px");
        });
        $("div#footer a[href$=#nowhere]").click(function(){
            alert("模仿天猫的连接，并没有跳转到实际的页面");
        });
        $("a.wangwanglink").click(function(){
            alert("模仿旺旺的图标，并不会打开旺旺");
        });

        $("a.notImplementLink").click(function(){
            alert("这个功能没做，蛤蛤~");
        });
    }

    Vue.filter("subStringFilter", function(value, start, end){
        if (!value)
            return '';
        return value.substring(start,end);
    });

    Vue.filter("formatMoneyFilter", function(value){
        return formatMoney(value);
    });

    Vue.filter('formatDateFilter', function (value, formatString) {
        if(null==value)
            return "";
        formatString = formatString || 'YYYY-MM-DD HH:mm:ss';
        return moment(value).format(formatString);
    });
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

