<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div >
    <script>
        $(function(){
            var data4Vue = {
                uri:'forelogin',
                result: [],
                user:{name:'', password:''}
            };
            //ViewModel
            var vue = new Vue({
                el: '#workingArea',
                data: data4Vue,
                mounted:function(){
                    linkDefaultActions();
                },
                methods: {
                    login:function(){
                        var url =  this.uri;
                        if(0==this.user.name.length){
                            $("span.errorMessage").html("请输入用户名");
                            $("div.loginErrorMessageDiv").css("visibility","visible");
                            return;
                        }
                        if(0==this.user.password.length){
                            $("span.errorMessage").html("请输入密码");
                            $("div.loginErrorMessageDiv").css("visibility","visible");
                            return;
                        }

                        axios.post(url,this.user).then(function(response) {
                            var result = response.data;
                            if(result.code==0){
                                location.href="home";
                            }
                            else{
                                $("span.errorMessage").html(result.message);
                                $("div.loginErrorMessageDiv").css("visibility","visible");
                            }
                        });
                    }
                }
            });

            var left = window.innerWidth/2+162;
            $("div.loginSmallDiv").css("left",left);
        })
    </script>

    <div id="loginDiv" style="position: relative">
        <div class="simpleLogo">
            <a href="${pageContext.request.contextPath}"><img src="img/site/simpleLogo.png"></a>
        </div>
        <img id="loginBackgroundImg" class="loginBackgroundImg" src="img/site/loginBackground.png">
        <div id="loginSmallDiv" class="loginSmallDiv">
            <div class="loginErrorMessageDiv">
                <div class="alert alert-danger" >
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
                    <span class="errorMessage">22</span>
                </div>
            </div>

            <div class="login_acount_text">账户登录</div>
            <div class="loginInput " >
                    <span class="loginInputIcon ">
                        <span class=" glyphicon glyphicon-user"></span>
                    </span>
                <input v-model="user.name" placeholder="手机/会员名/邮箱" type="text">
            </div>

            <div class="loginInput " >
                    <span class="loginInputIcon ">
                        <span class=" glyphicon glyphicon-lock"></span>
                    </span>
                <input v-model="user.password" type="password" placeholder="密码">
            </div>
            <span class="text-danger">不要输入真实的天猫账号密码</span><br><br>
            <div>
                <a class="notImplementLink" href="#nowhere">忘记登录密码</a>
                <a href="register" class="pull-right">免费注册</a>
            </div>
            <div style="margin-top:20px">
                <button class="btn btn-block redButton" type="button" @click="login">登录</button>
            </div>
        </div>
    </div>
</div>