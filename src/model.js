var mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/mongoose-benchmark');

var ObjectId = mongoose.Schema.Types.ObjectId;

var Token = {
    instanceId : ObjectId,
    deviceId : String,
    time : Date
};

var Schema = new mongoose.Schema({
    _id: String,
    schemaVersion: {
        type: String,
        "default": "2.00"
    },
    token: {
        type: Token,
        index: true,
        unique: true
    },
    createdAt: {
        type: Date,
        "default": Date.now
    },
    lastUpdate: {
        type: Date,
        expires: 3600 * 3,
        "default": Date.now
    },
    apps: {
        type: [String],
        "default": []
    },
    search: {
        type: [String]
    },
    appsToCrawl: {
        type: [String]
    },
    userId: {
        type: ObjectId,
    },
    SAID: {
        type: ObjectId
    },
    news: {
        type: Object
    },
    forYou: {
        type: Object
    },
    userData: {
        friends: {
            type: [ObjectId]
        },
        friendsApps: {
            type: [{
                _id: String,
                friends: Number
            }]
        },
        userId: {
            type: ObjectId
        },
        users: {
            type: Number
        },
        apps: {
            counters: {
                installed: {
                    type: Number
                },
                profile: {
                    type: Object
                }
            }
        },
        recommended: {
            type: [String]
        },
        unfollow: {
            type: Array,
            "default": []
        },
        follow: {
            type: Array,
            "default": []
        },
        newFollow: {
            type: Array,
            "default": []
        },
        followCount: Number,
        feature: Object,
    },
    leaders: {
        type: Array,
        "default": []
    },
    searchUser: {
        type: Array,
        "default": []
    },
    clientVersion: {
        type: Number
    },
    people: {
        around_me: {
            type: Object,
            "default": null
        },
        top_followed: {
            type: Object,
            "default": null
        },
        like_me: {
            type: Object,
            "default": null
        },
        may_know: {
            type: Object,
            "default": null
        }
    },
    info: {
        country: {
            type: String
        },
        deviceName: {
            type: String
        },
        deviceVersion: {
            type: String
        },
        deviceCommonName: {
            type: String
        },
        deviceProperties: {
            type: Object
        },
        lang: {
            type: String
        },
        deviceLang: {
            type: String,
        },
        geo: {
            type: Object
        },
        IPv4: {
            type: String
        },
        IPv6: {
            type: String
        },
        ipCountry: {
            type: String
        },
        ipCountryCode: {
            type: String
        },
        isTablet: {
            type: Boolean
        }
    }
});

module.exports = mongoose.model('Test', Schema);
