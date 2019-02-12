import React from "react"
import PropTypes from "prop-types"
import { withStyles } from "@material-ui/core/styles"
import Typography from "@material-ui/core/Typography"

const styles = theme => ({
  root: {
    textAlign: "center",
    height: "70vh",
    display: "flex",
    alignItems: "center",
    flexDirection: "column",
    justifyContent: "center"
  },
  header: {
    color: "#AAAAAA"
  },
  paragraph: {
    color: "#AAAAAA"
  }
})

function ExceptionInfo(props) {
  const { classes, status } = props

  var status_txt = ""

  if (status == 422) {
    status_txt = "Rejected"
  } else if (status == 404) {
    status_txt = "Not Found"
  } else {
    status_txt = "This probably shouldn't have happened..."
  }

  return (
    <div className={classes.root}>
      <Typography component="h1" variant="h3" className={classes.header} gutterBottom>
        {status}
      </Typography>
      <Typography component="p" variant="body1" className={classes.paragraph} gutterBottom>
        {status_txt}
      </Typography>
    </div>
  )
}

ExceptionInfo.propTypes = {
  classes: PropTypes.object.isRequired,
  status: PropTypes.number
}

export default withStyles(styles)(ExceptionInfo)
