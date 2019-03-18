import React from "react"
import PropTypes from "prop-types"
import { withStyles } from "@material-ui/core/styles"
import Card from "@material-ui/core/Card"
import CardActionArea from "@material-ui/core/CardActionArea"
import CardActions from "@material-ui/core/CardActions"
import CardContent from "@material-ui/core/CardContent"
import CardMedia from "@material-ui/core/CardMedia"
import Link from "@material-ui/core/Link"
import Typography from "@material-ui/core/Typography"
import Avatar from "@material-ui/core/Avatar"
import deepOrange from "@material-ui/core/colors/deepOrange"
import deepPurple from "@material-ui/core/colors/deepPurple"
import green from "@material-ui/core/colors/green"
import _ from "lodash"
// TODO:
//import Grid from "@material-ui/core/Grid"

import StockChip from "./StockChip"

const styles = (theme) => ({
  card: {
    maxWidth: 360,
    width: 360,
    [theme.breakpoints.down(441)]: {
      maxWidth: "unset",
      width: "unset"
    }
  },
  cardActions: {
    paddingLeft: "8px",
    paddingRight: "8px"
  },
  media: {
    objectFit: "cover"
  },
  link: {
    margin: 0
  }
})

function ProductCard(props) {
  const { classes, img, vendor, handle, strain, plant, available, title } = props

  var strain_txt = ""
  if (strain) { strain_txt += " (" + strain + ")" }

  var plant_type = _.slice(plant, 0, 1)
  var plant_type_styles = { color: "#FFFFFF" }
  if (plant_type == "S") {
    plant_type_styles.backgroundColor = deepOrange[300]
  } else if (plant_type == "I") {
    plant_type_styles.backgroundColor = deepPurple[300]
  } else {
    plant_type_styles.backgroundColor = green["300"]
  }

  const ocs_link = "https://ocs.ca/products/" + handle

  var v_default

  // TODO I hate this lol but I'm lazy af right now
  if (typeof available.p_default == "boolean" && !available.p_1g &&
    !available.p_3_5g && !available.p_7g && !available.p_15g) {
    v_default = (
      <StockChip inStock={available.p_default} amount="I"></StockChip>
    )
  } else {
    v_default = ""
  }

  return (
    <Card className={"card " + classes.card}>
      <Link href={ocs_link} color="inherit" className={classes.link}>
        <CardActionArea>
          <CardMedia
            component="img"
            alt={title + " branding"}
            className={classes.media}
            height="140"
            image={img}
            title={title}
          />
          <CardContent>
            <Typography gutterBottom variant="h6" component="h2">
              {title}{strain_txt}
            </Typography>
            <Typography gutterBottom variant="caption">
              by: {vendor}
            </Typography>
          </CardContent>
        </CardActionArea>
      </Link>
      <CardActions className={classes.cardActions + " card--actions"}>
        <div className="card--actions--type">
          <Avatar style={plant_type_styles}>{plant_type}</Avatar>
        </div>
        <div className="card--actions--stock">
          {v_default}
          <StockChip inStock={available.p_1g} amount="1g"></StockChip>
          <StockChip inStock={available.p_3_5g} amount="3.5g"></StockChip>
          <StockChip inStock={available.p_7g} amount="7g"></StockChip>
          <StockChip inStock={available.p_15g} amount="15g"></StockChip>
        </div>
      </CardActions>
    </Card>
  )
}

// TODO: add additional prop types!
ProductCard.propTypes = {
  classes: PropTypes.object.isRequired
}

export default withStyles(styles)(ProductCard)
