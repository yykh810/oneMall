<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div   class="modal " id="loginModal" tabindex="-1" role="dialog" >
    <div class="modal-dialog loginDivInProductPageModalDiv">
        <div class="modal-content">
            <div class="loginDivInProductPage">
                <div class="loginErrorMessageDiv">
                    <div class="alert alert-danger" >
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
                        <span class="errorMessage"></span>
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
                    <input v-model="user.password" type="password" placeholder="密码" type="text">
                </div>
                <span class="text-danger">不要输入真实的天猫账号密码</span><br><br>
                <div>
                    <a class="notImplementLink" href="#nowhere">忘记登录密码</a>
                    <a href="register" class="pull-right">免费注册</a>
                </div>
                <div style="margin-top:20px">
                    <button class="btn btn-block redButton loginSubmitButton" type="submit">登录</button>
                </div>
            </div>
        </div>
    </div>

</div>