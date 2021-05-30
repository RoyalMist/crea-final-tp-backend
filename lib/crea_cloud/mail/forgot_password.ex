defmodule CreaCloud.Mail.ForgotPassword do
  require EEx
  alias CreaCloud.Mail

  @template_path Path.join([__DIR__, "forgot_password.mjml"])
  @external_resource @template_path

  rendered_mjml = Mail.generate_template(@template_path)
  EEx.function_from_string(:def, :render, rendered_mjml, [:assigns])
end
