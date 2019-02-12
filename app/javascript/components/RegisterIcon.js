import React from "react"
import PropTypes from "prop-types"
import { withStyles } from "@material-ui/core/styles"
import OkIcon from "@material-ui/icons/SentimentVerySatisfied"
import ErrorIcon from "@material-ui/icons/SentimentDissatisfied"

const styles = theme => ({
  root: {
    textAlign: "center",
    margin: "1rem 0"
  },
  icon: {
    color: "#AAAAAA"
  }
})

function RegisterIcon(props) {
  const { classes, ok } = props

  const icon = ok ? (
    <OkIcon className={classes.icon} fontSize="large">
    </OkIcon>
  ) : (
    <ErrorIcon className={classes.icon} fontSize="large">
    </ErrorIcon>
  )

  return (
    <div className={classes.root}>
      {icon}
    </div>
  )
}

RegisterIcon.propTypes = {
  classes: PropTypes.object.isRequired,
}

export default withStyles(styles)(RegisterIcon)
