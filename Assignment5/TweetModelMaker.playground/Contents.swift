import Cocoa
import CreateML

//Get data file
let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/masummodi/Downloads/twitter-data.csv"))

//Get random 20% of actual data for training
let(trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

//Add classifier
let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")
let evaluationMetrics = sentimentClassifier.evaluation(on: testingData, textColumn: "text", labelColumn: "class")

let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

//Create meta data
let metaData = MLModelMetadata(author: "Masum Manoj", shortDescription: "Model to train tweets", version: "1.0")

try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/masummodi/Downloads/TweetSentimentModel.mlmodel"))

try sentimentClassifier.prediction(from: "Apple iphone 13 has issues!")

try sentimentClassifier.prediction(from: "@Cocacola is the best drink.")

