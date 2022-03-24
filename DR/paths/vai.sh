rm Jpsi.txt

xrdfs xrootd-redir.ultralight.org ls -u /store/group/uerj/mabarros/CRAB_PrivateMC_RunII_UL_2017/Jpsi/220316_011129/0000 > a0.txt
xrdfs xrootd-redir.ultralight.org ls -u /store/group/uerj/mabarros/CRAB_PrivateMC_RunII_UL_2017/Jpsi/220316_011129/0001 > a1.txt
xrdfs xrootd-redir.ultralight.org ls -u /store/group/uerj/mabarros/CRAB_PrivateMC_RunII_UL_2017/Jpsi/220316_011129/0002 > a2.txt
xrdfs xrootd-redir.ultralight.org ls -u /store/group/uerj/mabarros/CRAB_PrivateMC_RunII_UL_2017/Jpsi/220316_011129/0003 > a3.txt
xrdfs xrootd-redir.ultralight.org ls -u /store/group/uerj/mabarros/CRAB_PrivateMC_RunII_UL_2017/Jpsi/220316_011129/0004 > a4.txt
xrdfs xrootd-redir.ultralight.org ls -u /store/group/uerj/mabarros/CRAB_PrivateMC_RunII_UL_2017/Jpsi/220316_011129/0005 > a5.txt
xrdfs xrootd-redir.ultralight.org ls -u /store/group/uerj/mabarros/CRAB_PrivateMC_RunII_UL_2017/Jpsi/220316_011129/0006 > a6.txt
xrdfs xrootd-redir.ultralight.org ls -u /store/group/uerj/mabarros/CRAB_PrivateMC_RunII_UL_2017/Jpsi/220316_011129/0007 > a7.txt
xrdfs xrootd-redir.ultralight.org ls -u /store/group/uerj/mabarros/CRAB_PrivateMC_RunII_UL_2017/Jpsi/220316_011129/0008 > a8.txt
xrdfs xrootd-redir.ultralight.org ls -u /store/group/uerj/mabarros/CRAB_PrivateMC_RunII_UL_2017/Jpsi/220316_011129/0009 > a9.txt
xrdfs xrootd-redir.ultralight.org ls -u /store/group/uerj/mabarros/CRAB_PrivateMC_RunII_UL_2017/Jpsi/220316_011129/0010 > a10.txt

cat a0.txt a1.txt a2.txt a3.txt a4.txt a5.txt a6.txt a7.txt a8.txt a9.txt a10.txt > Jpsi.txt

rm a*.txt
