{
  # Enable the portfolio service
  services.portfolio = {
    enable = true;
    
    # Optional: Change port (default: 3000)
    port = 3000;
    
    # Optional: Change host (default: "127.0.0.1")
    host = "127.0.0.1";
    
    # Optional: Enable nginx reverse proxy with SSL
    proxy = {
      enable = true;
      domain = "nolan.uz";  # Your domain name
    };
    
    # Optional: Change user/group (defaults: "portfolio")
    # user = "portfolio";
    # group = "portfolio";
  };
  
  # Make sure nginx is enabled if using proxy
  services.nginx.enable = true;
  
  # ACME (Let's Encrypt) configuration for SSL certificates
  security.acme = {
    acceptTerms = true;  # Accept Let's Encrypt terms of service
    defaults.email = "javohirtech@gmail.com";  # TODO: Replace with your email address
  };
}