const mongoose = require('mongoose');

const recipeSchema = new mongoose.Schema({
    name: { type: String, required: true },
    description: { type: String, required: true },
    calories: { type: Number, required: true },
    proteins: { type: Number, required: true },
    fats: { type: Number, required: true },
    carbs: { type: Number, required: true },
    grams: { type: Number, required: true },
    photo: { type: String }, // URL to the photo
    videoLink: { type: String } // URL to the video
}, { timestamps: true });

module.exports = mongoose.model('Recipe', recipeSchema);
