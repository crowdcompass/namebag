zone "crwd.cc" do
  a "173.255.212.121"
end

zone "crowdcompass.com" do
  a "69.163.194.163"
  a "projects", "173.255.212.169" 

  # Dreamhost
  ip "69.163.194.163", "www", "ftp", "svn", "ftp.svn", "www.svn"
  ip "69.163.153.10", "db", "sql"
  ip "69.163.194.49", "sales", "ftp.sales", "www.sales"

  # Linode
  ip "173.230.147.97", "chat", "api", "hub"
  ip "173.255.212.122", "dev", "demo", "v2-staging", wildcards: true
  ip "173.255.212.123", "utility1"
  ip "74.207.245.204", "v1", "v1-1", "v1-1-staging", wildcards: true
  ip "173.255.212.121", "v2", wildcards: true
  ip "173.236.160.106", "sandbox", "ftp.sandbox", "www.sandbox"
  ip "173.236.242.177", "sinatra", "ftp.sinatra", "www.sinatra"

  cname "calendar", "ghs.google.com."
  cname "docs", "ghs.google.com."
  cname "sites", "ghs.google.com."

  txt "google-site-verification=-GlKltHYqepTFWAsE5oiD5TZoaPgedLDvjT8dtAe6-o"

  mx "0 aspmx.l.google.com"
end

__END__
2011nascc   CNAME   v2.crowdcompass.com.
alta2010  CNAME   v1-1.crowdcompass.com.
cme2011   CNAME   v2.crowdcompass.com.
cuao2010  CNAME   v1-1.crowdcompass.com.
emobile   CNAME   api-sandbox.crowdcompass.com. 
eventtech2010   CNAME   v1-1.crowdcompass.com.
iadr2011  CNAME   v2.crowdcompass.com.
lci2011   CNAME   v2.crowdcompass.com.
lcul2010  CNAME   v1-1.crowdcompass.com.
nwbankruptcyinst  CNAME   v2.crowdcompass.com.
nwes2010  CNAME   v1-1.crowdcompass.com.
nwsecuritiesinst  CNAME   v2.crowdcompass.com.
nyc11   CNAME   v2.crowdcompass.com.
odc2011   CNAME   v2.crowdcompass.com.
oenao2011   CNAME   v2.crowdcompass.com.
osblitiginst  CNAME   v2.crowdcompass.com.
osbpowerplay2010  CNAME   v1-1.crowdcompass.com.
pedalnation2011   CNAME   v2.crowdcompass.com.
pedalntn2011  CNAME   v2.crowdcompass.com.
pittcon2011   CNAME   v2.crowdcompass.com.
reimagine   CNAME   v1-1.crowdcompass.com.
spj2010   CNAME   v1-1.crowdcompass.com.
sugarcon2011  CNAME   v2.crowdcompass.com.
sugarcrm  CNAME   v1.crowdcompass.com.
vnw2010   CNAME   v1-1.crowdcompass.com.
wcul  CNAME   v1-1.crowdcompass.com.
