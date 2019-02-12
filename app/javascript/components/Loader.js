import React from "react"
import PropTypes from "prop-types"
import { withStyles } from "@material-ui/core/styles"
import CircularProgress from "@material-ui/core/CircularProgress"

const styles = theme => ({
  root: {
    textAlign: "center",
    height: "70vh",
    display: "flex",
    alignItems: "center",
    flexDirection: "column",
    justifyContent: "center"
  },
  progress: {
    margin: ".5rem",
  }
})

function Loader(props) {
  const { classes } = props

  document.getElementById
  return (
    <div className={classes.root}>
      <CircularProgress className={classes.progress} color="secondary" />
    </div>
  )
}

Loader.propTypes = {
  classes: PropTypes.object.isRequired,
}

export default withStyles(styles)(Loader)
