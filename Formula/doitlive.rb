class Doitlive < Formula
  include Language::Python::Virtualenv

  desc "Replay stored shell commands for live presentations"
  homepage "https://doitlive.readthedocs.io/en/latest/"
  url "https://files.pythonhosted.org/packages/e5/d9/4ce969d98f521c253ec3b15a0c759104a01061ac90fb9d8636b015bcb4ea/doitlive-4.3.0.tar.gz"
  sha256 "4cb1030e082d8649f10a61d599d3ff3bcad7f775e08f0e68ee06882e06d0190f"
  license "MIT"
  revision 11
  head "https://github.com/sloria/doitlive.git", branch: "dev"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ca1a1f1aea885860e82beada9dff81d971f89acbac90e872279a1b74d196c566"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c53819a626934205ac4b32eadb316fc4c3bf287fccc513ff313396bedd002dad"
    sha256 cellar: :any_skip_relocation, monterey:       "18a0656dfd0262f370d21919bb0a2649edc63c3be6295edee3feb50aa6d493c9"
    sha256 cellar: :any_skip_relocation, big_sur:        "2cbd6954dd362112f2a1a9eb1226ea506721eb64efe37af548359eef5f116410"
    sha256 cellar: :any_skip_relocation, catalina:       "0099d450d5512214450d1eec180df1b1b18e114a2b7e9255e720c31dc5c42449"
    sha256 cellar: :any_skip_relocation, mojave:         "5414c94f952d6394a59752a9e4f6e3a303e93eeb6722a64fd0eba975dcc2ee57"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8d33aec040b27e6d8786e005911c0ab20e2201cecb7694bcdafc46d4ef29e78e"
  end

  depends_on "python@3.10"
  depends_on "six"

  resource "click" do
    url "https://files.pythonhosted.org/packages/59/87/84326af34517fca8c58418d148f2403df25303e02736832403587318e9e8/click-8.1.3.tar.gz"
    sha256 "7682dc8afb30297001674575ea00d1814d808d6a36af415a82bd481d37ba7b8e"
  end

  resource "click-completion" do
    url "https://files.pythonhosted.org/packages/93/18/74e2542defdda23b021b12b835b7abbd0fc55896aa8d77af280ad65aa406/click-completion-0.5.2.tar.gz"
    sha256 "5bf816b81367e638a190b6e91b50779007d14301b3f9f3145d68e3cade7bce86"
  end

  resource "click-didyoumean" do
    url "https://files.pythonhosted.org/packages/2f/a7/822fbc659be70dcb75a91fb91fec718b653326697d0e9907f4f90114b34f/click-didyoumean-0.3.0.tar.gz"
    sha256 "f184f0d851d96b6d29297354ed981b7dd71df7ff500d82fa6d11f0856bee8035"
  end

  resource "Jinja2" do
    url "https://files.pythonhosted.org/packages/7a/ff/75c28576a1d900e87eb6335b063fab47a8ef3c8b4d88524c4bf78f670cce/Jinja2-3.1.2.tar.gz"
    sha256 "31351a702a408a9e7595a8fc6150fc3f43bb6bf7e319770cbc0db9df9437e852"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/1d/97/2288fe498044284f39ab8950703e88abbac2abbdf65524d576157af70556/MarkupSafe-2.1.1.tar.gz"
    sha256 "7f91197cc9e48f989d12e4e6fbc46495c446636dfc81b9ccf50bb0ec74b91d4b"
  end

  resource "shellingham" do
    url "https://files.pythonhosted.org/packages/9c/c9/a3e3bc667c8372a74aa4b16649c3466364cd84f7aacb73453c51b0c2c8a7/shellingham-1.4.0.tar.gz"
    sha256 "4855c2458d6904829bd34c299f11fdeed7cfefbf8a2c522e4caea6cd76b3171e"
  end

  def install
    virtualenv_install_with_resources

    output = Utils.safe_popen_read({ "SHELL" => "bash" }, libexec/"bin/doitlive", "completion")
    (bash_completion/"doitlive").write output

    output = Utils.safe_popen_read({ "SHELL" => "zsh" }, libexec/"bin/doitlive", "completion")
    (zsh_completion/"_doitlive").write output
  end

  test do
    system "#{bin}/doitlive", "themes", "--preview"
  end
end
