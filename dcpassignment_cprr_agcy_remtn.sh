. $HOME/.bash_profile
############################################################################
#
#	Script Name: dcpassignment_cprr_agcy_remtn_file_archive.sh <Agcy_path>
#
#   Agcy_path: agency and sytem name eg:dcas/dcastas
#
#	Written By: Tanuja R     
#	Date:
#
#	This script is used to archive the remittance files for dcpassignment
#
############################################################################
# - TLCCONNECT_PAY
############################################################################
#set -x

TIME=`date '+%Y%m%d'`T`date '+%H%M%S'`
SOURCEFILEDIR=$FTPPath/dcp/dcpassignment/stg/outbnd/data
ARCHIVEDIR=$FTPPath/dcp/dcpassignment/stg/outbnd/data
## ftp_data2 mount point
SOURCEFILEDIR2=$FTPPath2/dcpassignment/upload/$INST/outbnd/data

cd $SOURCEFILEDIR
pwd

TLCCONNECT_FILE_NM=dcpaddrasgnmnt_pay
HDR_CNT=`cat dcpaddrasgnmnt_pay.daily.txt| wc -l`


if [ $HDR_CNT = 0 ]
then
	
	echo "`date '+%Y%m%d'`|0|0.00|0|0.00|"dcpaddrasgnmnt_pay.txt > dcpaddrasgnmnt_pay.daily.cnt.txt
	cp dcpaddrasgnmnt_pay.daily.cnt.txt dcpaddrasgnmnt_pay.$TIME.daily.cnt.txt
	cp dcpaddrasgnmnt_pay.*.daily.cnt.txt $SOURCEFILEDIR2
else
	
	cp dcpaddrasgnmnt_pay.daily.txt $SOURCEFILEDIR/dcpaddrasgnmnt_pay.$TIME.daily.txt 
        cp dcpaddrasgnmnt_pay.*.daily.txt $SOURCEFILEDIR2

	cp dcpaddrasgnmnt_pay.daily.cnt.txt $SOURCEFILEDIR/dcpaddrasgnmnt_pay.$TIME.daily.cnt.txt
	cp dcpaddrasgnmnt_pay.*.daily.cnt.txt $SOURCEFILEDIR2
fi

########################
# Tar and remove files #
########################
DTSTAMP=`date '+%Y%m%dT%H%M%S'`
tar -cvf dcpaddrasgnmnt_pay.$DTSTAMP.tar dcpaddrasgnmnt_pay*.txt

mv dcpaddrasgnmnt_pay.*.tar $FTPPath/dcp/dcpassignment/stg/outbnd/archive
rm dcpaddrasgnmnt_pay*.txt

#set +x

exit
