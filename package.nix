{
	buildGoModule,
	fetchFromGitLab,
	lib,
  }:
  
  buildGoModule rec {
	pname = "devboxpackage";
	version = "0.0.1";
  
	src = fetchFromGitLab {
	  owner = "mr_vinkel";
	  repo = pname;
	  rev = "v${version}";
	  hash = "sha256-d638eaf366524e3017ee8bfabded5a7ed81a59de";
	};
  
	vendorHash = null;
  
	meta = with lib; {
	  description = "Test package";
	  homepage = "https://gitlab.com/mr_vinkel/devboxpackage";
	  changelog = "https://gitlab.com/mr_vinkel/devboxpackage/-/releases";
	  license = licenses.unlicense;
	  maintainers = with maintainers; [ mr_vinkel ];
	};
  }