# Helper Functions
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Erik.Leppo@tetratech.com (EWL)
# 20150805
# 20210521, EWL, copied from ContDataQC package
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Status Message
#
# Reports progress back to the user in the console.
# @param fun.status Date, Time, or DateTime data
# @param fun.item.num.current current item
# @param fun.item.num.total total items
# @param fun.item.name name of current item
#
# @return Returns a message to the console
#
# @keywords internal
#
# @examples
# #Not intended to be accessed independently.
#
## for informing user of progress
# @export
fun.Msg.Status <- function(fun.status
                           , fun.item.num.current
                           , fun.item.num.total
                           , fun.item.name) {
  ## FUNCTION.START
  print(paste("Processing item "
              ,fun.item.num.current
              ," of "
              ,fun.item.num.total
              ,", "
              ,fun.status
              ,", "
              ,fun.item.name
              ,"."
              ,sep=""))
} ## FUNCTION.END
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Log write
#
# Writes status information to a log file.
#
# @param fun.Log information to write to log
# @param fun.Date current date (YYYYMMDD)
# @param fun.Time current time (HHMMSS)
# @param fun.item.name item name
#
# @return Returns a message to the console
#
# @keywords internal
#
# @examples
# #Not intended to be accessed independently.
#
## write log file
# @export
fun.write.log <- function(fun.Log, fun.Date, fun.Time) {#FUNCTION.START
  utils::write.table(fun.Log
                     , file=paste("LOG.Items."
                                  , fun.Date
                                  , "."
                                  , fun.Time
                                  ,".tab"
                                  , sep="")
                     , sep="\t"
                     , row.names=FALSE
                     , col.names=TRUE)
}#FUNCTION.END
