{vars, ...}: {
  programs.git = {
    enable = true;
    userName = vars.fullName;
    userEmail = vars.userEmail;
  };
}
