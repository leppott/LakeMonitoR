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

