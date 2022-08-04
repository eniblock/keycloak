<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>
    <#if section = "header">
        ${msg("emailForgotTitle")}
    <#elseif section = "form">
        <h2 id="kc-form-title"  class="kc-form-title-${properties.kcCssColor!}">${msg("forgotPasswordTitle")}</h2>
        <form id="kc-reset-password-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcInputWrapperClass!}">
                    <div class="mdc-text-field mdc-text-field--filled ${properties.kcLabelClass!}">
                        <input type="text" id="username" name="username"
                               class="mdc-text-field__input ${properties.kcInputClass!}"
                               autofocus
                               required
                               value=""
                               aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"/>
                        <div class="${properties.kcLabelWrapperClass!}">
                            <label for="username"
                                   class="mdc-floating-label ${properties.kcLabelClass!}">${msg("email")}</label>
                        </div>
                    </div>
                    <#if messagesPerField.existsError('username')>
                        <span id="input-error-username" class="${properties.kcInputErrorMessageClass!}"
                              aria-live="polite">
                                    ${kcSanitize(messagesPerField.get('username'))?no_esc}
                        </span>
                    </#if>
                </div>
            </div>
            <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}" >
                    <button class="mdc-button mdc-button--raised mdc-login-button ${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                            type="submit" style="background-color:${properties.kcCssSignColor!} !important;">
                        ${msg("doSubmit")}
                    </button>
                </div>
            </div>
        </form>
        <div class="${properties.kcFormOptionsWrapperClass!}">
            <div id="footer-container"  class="footer-container-${properties.kcCssColor!}">
                <div id="kc-footer-button">
                    <a href="${url.loginUrl}">
                        ${msg("backToLogin")}
                    </a>
                </div>
            </div>
        </div>
    <#elseif section = "info" >
    <#--        <#if realm.duplicateEmailsAllowed>-->
    <#--            ${msg("emailInstructionUsername")}-->
    <#--        <#else>-->
    <#--            ${msg("emailInstruction")}-->
    <#--        </#if>-->
    </#if>
</@layout.registrationLayout>
