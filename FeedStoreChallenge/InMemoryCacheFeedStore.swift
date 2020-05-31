//
//  InMemoryCacheFeedStore.swift
//  FeedStoreChallenge
//
//  Created by panditpakhurde on 22/05/20.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation

public class InMemoryCacheFeedStore: FeedStore {
    final class Cache {
        internal let feed: [LocalFeedImage]
        internal let timestamp: Date
        
        init(feed: [LocalFeedImage], timestamp: Date) {
            self.feed = feed
            self.timestamp = timestamp
        }
    }
    
    private let key = NSUUID()
    private let memoryCache = NSCache<NSUUID, Cache>()

    public init() {}
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        memoryCache.removeObject(forKey: key)
        completion(nil)
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        let cache = Cache(feed: feed, timestamp: timestamp)
        memoryCache.setObject(cache, forKey: key)
        completion(nil)
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        guard let cache = memoryCache.object(forKey: key) else {
            return completion(.empty)
        }
        completion(.found(feed: cache.feed, timestamp: cache.timestamp))
    }
}
