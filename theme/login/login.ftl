<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>

    <div id="kc-form-login-container">
        <#if section = "form">
            <#if realm.password>
                <h2 id="kc-form-title" class="kc-form-title-${properties.kcCssColor!}">${msg("loginTitle")}</h2>
                <form id="kc-form-login" class="form ${properties.kcFormClass!}" action="${url.loginAction}"
                      method="post">
                    <div class="username-container ${properties.kcFormGroupClass!}">
                        <div class="${properties.kcInputWrapperClass!}">
                            <div class="mdc-text-field mdc-text-field--filled ${properties.kcLabelClass!} <#if usernameEditDisabled??>mdc-text-field--disabled</#if>">
                                <input required id="username" class="mdc-text-field__input ${properties.kcInputClass!}"
                                       name="username" value="${(login.username!'')}" type="text"
                                       <#if usernameEditDisabled??>disabled</#if>>
                                <div class="${properties.kcLabelWrapperClass!}">
                                    <label for="username"
                                           class="mdc-floating-label ${properties.kcLabelClass!}">
                                        ${msg("email")}
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="password-container ${properties.kcFormGroupClass!}">
                        <div class="${properties.kcInputWrapperClass!}">

                            <div class="mdc-text-field mdc-text-field--filled ${properties.kcLabelClass!}">
                                <input required id="password" class="mdc-text-field__input ${properties.kcInputClass!}"
                                       name="password" type="password">
                                <i onclick="show('password')"
                                   class="eye-icon material-icons mdc-text-field__icon mdc-text-field__icon--trailing"
                                   tabindex="-1" role="button">remove_red_eye</i>
                                <div class="${properties.kcLabelWrapperClass!}">
                                    <label for="password"
                                           class="mdc-floating-label ${properties.kcLabelClass!}">${msg("password")} </label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <#if realm.resetPasswordAllowed>
                        <div id="forgotPasswordContainer">
                            <a class="nav-link"
                               href="${url.loginResetCredentialsUrl}" style="color:${properties.kcCssLinkColor!} !important;">${msg("doForgotPassword")}</a>
                        </div>
                    </#if>

                    <div class="${properties.kcFormGroupClass!}">
                        <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                            <div id="rememberMeContainer" class="col-xs-7">
                                <#if realm.rememberMe && !usernameEditDisabled??>

                                    <div class="mdc-form-field remember-me-checkbox">
                                        <div class="mdc-checkbox">
                                            <input type="checkbox"
                                                   name="rememberMe"
                                                   class="mdc-checkbox__native-control"
                                                   id="rememberMe"
                                                   <#if login.rememberMe??>checked</#if>
                                            />
                                            <div class="mdc-checkbox__background">
                                                <svg class="mdc-checkbox__checkmark"
                                                     viewBox="0 0 24 24">
                                                    <path class="mdc-checkbox__checkmark-path"
                                                          fill="none"
                                                          stroke="white"
                                                          d="M1.73,12.91 8.1,19.28 22.79,4.59"/>
                                                </svg>
                                                <div class="mdc-checkbox__mixedmark"></div>
                                            </div>
                                        </div>
                                        <label for="rememberMe">${msg("rememberMe")}</label>
                                    </div>
                                </#if>
                            </div>
                            <div id="kc-form-buttons" class="col-xs-5 ${properties.kcFormButtonsClass!}" >

                                <button class="mdc-button mdc-button--raised ${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}"
                                        name="login" id="kc-login-button" type="submit" style="background-color:${properties.kcCssSignColor!} !important;">
                                    ${msg("doLogIn")}
                                </button>

                            </div>
                        </div>
                    </div>
                </form>
            </#if>
        <#elseif section = "info" >
            <#if realm.password && social.providers??>
                <span class="separator">${msg("or")}</span>
                <div id="kc-social-providers">
                    <#list social.providers as p>
                        <a href="${p.loginUrl}" id="zocial-${p.alias}" class="zocial ${p.alias} zocial-${properties.kcCssColor!}">
                            <img src="${url.resourcesPath}/img/${p.alias}.png" alt="${p.alias}">
                            <span class="text zocial-text">${msg("continue")} <span class="provider" >${p.alias}</span></span>
                        </a>
                    </#list>
                </div>
            </#if>

            <#if realm.password && realm.registrationAllowed && client.clientId == '${properties.clientId}'>
                <div id="footer-container" class="footer-container-${properties.kcCssColor!}">
                    <div id="kc-footer-button">
                        <a onclick="goToRegistration();return false;">
                            ${msg("goToRegister")}
                        </a>
                    </div>
                </div>
            </#if>

        </#if>
    </div>
</@layout.registrationLayout>
