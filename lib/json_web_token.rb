class JsonWebToken
    SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
    # Rails.application will give access to complete application like config,routes and secrets
    # Rails.application.secrets complete security keys, api keys, api credentials
    # secret_key_base - A specific secret used by Rails to generate session tokens, encrypt cookies, and sign data.
    def self.encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, SECRET_KEY)
    end

    def self.decode(token)
        decoded = JWT.decode(token, SECRET_KEY).first
        #  here token is taken from token controller that
        #  we have created.
        HashWithIndifferentAccess.new.decoded
    end

end