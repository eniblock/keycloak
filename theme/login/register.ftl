<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('email','username','password','password-confirm'); section>

    <#if messagesPerField.existsError('email')>
        <div class="alert alert-error">
            <span id="input-error-email" class="${properties.kcInputErrorMessageClass!}"
                  aria-live="polite">
                ${kcSanitize(messagesPerField.get('email'))?no_esc}
            </span>
        </div>
    </#if>

    <#if messagesPerField.existsError('password')>
        <div class="alert alert-error">
            <span id="input-error-password" class="${properties.kcInputErrorMessageClass!}"
                  aria-live="polite">
                ${kcSanitize(messagesPerField.get('password'))?no_esc}
            </span>
        </div>
    </#if>

    <#if section = "header">
        ${msg("registerTitle")}
    <#elseif section = "form">
        <h2 id="kc-form-title" class="kc-form-title-${properties.kcCssColor!}">${msg("registerTitle")}</h2>
        <form id="kc-register-form" class="${properties.kcFormClass!}" action="${url.registrationAction}" method="post">

            <div class="${properties.kcFormGroupClass!}">
                <div class="mdc-text-field mdc-text-field--filled ${properties.kcInputWrapperClass!}">
                    <input type="text" id="email" class="mdc-text-field__input ${properties.kcInputClass!}" name="email"
                           required
                           value="${(register.formData.email!'')}" autocomplete="email"
                           aria-invalid="<#if messagesPerField.existsError('email')>true</#if>"
                    />
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="email"
                               class="mdc-floating-label ${properties.kcLabelClass!}">${msg("email")}</label>
                    </div>
                </div>
            </div>

            <#if !realm.registrationEmailAsUsername>
                <div class="${properties.kcFormGroupClass!}">
                    <div class="mdc-text-field mdc-text-field--filled ${properties.kcInputWrapperClass!}">
                        <input type="text" id="username" class="mdc-text-field__input ${properties.kcInputClass!}"
                               name="username"
                               required
                               value="${(register.formData.username!'')}" autocomplete="username"
                               aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
                        />
                        <div class="${properties.kcLabelWrapperClass!}">
                            <label for="username"
                                   class="mdc-floating-label ${properties.kcLabelClass!}">${msg("username")}</label>
                        </div>
                    </div>
                </div>
            </#if>

            <#if passwordRequired??>
                <div class="${properties.kcFormGroupClass!}">
                    <div class="mdc-text-field mdc-text-field--filled ${properties.kcInputWrapperClass!}">
                        <input type="password" id="password" class="mdc-text-field__input ${properties.kcInputClass!}"
                               name="password"
                               required
                               autocomplete="new-password"
                               aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
                        />
                        <i onclick="show('password')"
                           class="eye-icon material-icons mdc-text-field__icon mdc-text-field__icon--trailing"
                           tabindex="-1" role="button">remove_red_eye</i>
                        <div class="${properties.kcLabelWrapperClass!}">
                            <label for="password"
                                   class="mdc-floating-label ${properties.kcLabelClass!}">${msg("passwordCreate")}</label>
                        </div>
                    </div>
                </div>

                <div class="${properties.kcFormGroupClass!}">
                    <div class="mdc-text-field mdc-text-field--filled ${properties.kcInputWrapperClass!}">
                        <input type="password" id="password-confirm"
                               class="mdc-text-field__input ${properties.kcInputClass!}"
                               required
                               name="password-confirm"
                               aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                        />
                        <i onclick="show('password-confirm')"
                           class="eye-icon material-icons mdc-text-field__icon mdc-text-field__icon--trailing"
                           tabindex="-1" role="button">remove_red_eye</i>
                        <div class="${properties.kcLabelWrapperClass!}">
                            <label for="password-confirm"
                                   class="mdc-floating-label ${properties.kcLabelClass!}">${msg("passwordConfirm")}</label>
                        </div>
                    </div>
                </div>
            </#if>

            <#if recaptchaRequired??>
                <div class="form-group">
                    <div class="${properties.kcInputWrapperClass!}">
                        <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                    </div>
                </div>
            </#if>

            <p id="privacy-policy">${msg("acceptPolicy")?no_esc}</p>

            <div class="${properties.kcFormGroupClass!}">

                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}" >
                    <button class="mdc-button mdc-button--raised ${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}"
                            id="kc-register-button" type="submit" style="background-color:${properties.kcCssSignColor!} !important;">
                        ${msg("doRegister")}
                    </button>
                </div>
            </div>
        </form>
    </#if>
    <div class="${properties.kcFormOptionsWrapperClass!}">
        <div id="footer-container" class="footer-container-${properties.kcCssColor!}">
            <div id="kc-footer-button">
                <a href="${url.loginUrl}">
                    ${msg("goToLogin")}
                </a>
            </div>
        </div>
    </div>
</@layout.registrationLayout>
